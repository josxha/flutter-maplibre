import 'package:flutter/material.dart';
import 'package:maplibre_example/utils/map_styles.dart';

class StyleDropdown extends StatefulWidget {
  const StyleDropdown({required this.onChanged, super.key});

  final void Function(MapStyles style) onChanged;

  static MapStyles get initStyle => MapStyles.openMapTilesLiberty;

  @override
  State<StyleDropdown> createState() => _StyleDropdownState();
}

class _StyleDropdownState extends State<StyleDropdown> {
  late MapStyles _selectedStyle = StyleDropdown.initStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<MapStyles>(
        value: _selectedStyle,
        items: MapStyles.values
            .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
            .toList(growable: false),
        onChanged: (value) {
          if (value == null) return;
          setState(() => _selectedStyle = value);
          widget.onChanged(value);
        },
      ),
    );
  }
}
