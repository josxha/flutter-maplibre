import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Records the pauses the shared map state hands to the platform.
class _PauseRecordingState extends MapLibreMapState {
  _PauseRecordingState(this.calls, {required this.canPause});

  final List<bool> calls;
  final bool canPause;

  @override
  bool get canPauseRendering => canPause;

  @override
  void setRenderingPaused({required bool paused}) => calls.add(paused);

  @override
  Widget buildPlatformWidget(BuildContext context) => const SizedBox.expand();

  // The controller calls are not under test.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakePlatform extends MapLibrePlatform with MockPlatformInterfaceMixin {
  _FakePlatform({this.canPause = true});

  final bool canPause;
  final calls = <bool>[];
  final states = <_PauseRecordingState>[];

  @override
  MapLibreMapState createWidgetState() {
    final state = _PauseRecordingState(calls, canPause: canPause);
    states.add(state);
    return state;
  }
}

void main() {
  late _FakePlatform platform;
  late List<MapEvent> events;

  setUp(() {
    platform = _FakePlatform();
    MapLibrePlatform.instance = platform;
    events = [];
  });

  Widget map({bool paused = false}) => Directionality(
    textDirection: TextDirection.ltr,
    child: MapLibreMap(paused: paused, onEvent: events.add),
  );

  List<bool> renderingEvents() => [
    for (final event in events)
      if (event is MapEventRenderingChanged) event.paused,
  ];

  testWidgets('a shown map renders', (tester) async {
    await tester.pumpWidget(map());
    expect(platform.calls, isEmpty);
    expect(platform.states.single.isRenderingPaused, isFalse);
    expect(renderingEvents(), isEmpty);
  });

  testWidgets('the paused flag pauses and resumes', (tester) async {
    await tester.pumpWidget(map(paused: true));
    expect(platform.calls, [true]);
    expect(platform.states.single.isRenderingPaused, isTrue);
    expect(renderingEvents(), [true]);

    await tester.pumpWidget(map());
    expect(platform.calls, [true, false]);
    expect(platform.states.single.isRenderingPaused, isFalse);
    expect(renderingEvents(), [true, false]);
  });

  testWidgets('an IndexedStack pauses the maps it hides', (tester) async {
    Widget stack(int index) => Directionality(
      textDirection: TextDirection.ltr,
      child: IndexedStack(index: index, children: [map(), const SizedBox()]),
    );

    await tester.pumpWidget(stack(0));
    expect(platform.calls, isEmpty);

    await tester.pumpWidget(stack(1));
    expect(platform.calls, [true]);
    expect(renderingEvents(), [true]);

    await tester.pumpWidget(stack(0));
    expect(platform.calls, [true, false]);
    expect(renderingEvents(), [true, false]);
    expect(platform.states, hasLength(1), reason: 'the map stays mounted');
  });

  testWidgets('a disabled TickerMode pauses the map', (tester) async {
    await tester.pumpWidget(TickerMode(enabled: false, child: map()));
    expect(platform.calls, [true]);

    await tester.pumpWidget(TickerMode(enabled: true, child: map()));
    expect(platform.calls, [true, false]);
  });

  testWidgets('a hidden map stays paused when the flag clears', (tester) async {
    await tester.pumpWidget(
      TickerMode(enabled: false, child: map(paused: true)),
    );
    await tester.pumpWidget(TickerMode(enabled: false, child: map()));
    expect(platform.calls, [true]);
    expect(platform.states.single.isRenderingPaused, isTrue);
  });

  testWidgets('a platform that cannot pause never reports a pause', (
    tester,
  ) async {
    MapLibrePlatform.instance = platform = _FakePlatform(canPause: false);
    await tester.pumpWidget(map(paused: true));
    expect(platform.calls, isEmpty);
    expect(platform.states.single.isRenderingPaused, isFalse);
    expect(renderingEvents(), isEmpty);
  });
}
