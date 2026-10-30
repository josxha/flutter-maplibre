---
title: 'Expressions'
description: 'Typed style expressions for filters, data-driven and zoom-dependent styling.'
icon: lucide/function-square
weight: 101
---

# Expressions

Every property of a style layer is an `Expression<T>`, where `T` is the Dart
type it evaluates to: `num`, `String`, `bool`, `Color`, `Offset`, a `List` or a
spec enum like `LineCap`. A constant is `.literal(x)`; anything else is computed
by the map from the feature, the zoom level and more. See the
[expressions of the style spec](https://maplibre.org/maplibre-style-spec/expressions/)
for what each one does.

```dart
final layer = CircleStyleLayer(
  id: 'quakes',
  sourceId: 'quakes',
  filter: .all([
    .greaterThan(.get('mag').asNumber(), .literal(5)),
    .has('place'),
  ]),
  radius: .interpolate(.exponential(2), .zoom(), {
    5: .literal(2),
    10: .literal(8),
  }),
  color: .match(
    .get('type'),
    {'major': const .literal(Color(0xFFFF0000))},
    fallback: const .literal(Color(0xFF888888)),
  ),
);
```

Dot shorthands need a parameter type to resolve against, so they don't work as
operands of an operator. Start with `Expression.` there:
`Expression.get('mag').asNumber() > .literal(5)`.

## Names

Spec names are kept, except where they clash with Dart keywords or members:

| Spec | Dart |
|---|---|
| `case` | `Expression.select([(test, output), …], fallback: …)` |
| `in` | `list.contains(item)`, `string.contains(substring)` |
| `let` / `var` | `Expression.withVariable(name, value, (v) => … v.use() …)` |
| `!` | `expression.not()` |
| `==`, `!=` | `Expression.equal(a, b)`, `Expression.notEqual(a, b)` |
| `>`, `<`, `>=`, `<=` | `Expression.greaterThan(a, b)` and so on, or the operators on number and string expressions |
| `+`, `-`, `*`, `/`, `%` | operators on number expressions; `+` on string expressions is `concat` |
| `^` | `base.pow(exponent)` |
| `typeof` | `expression.type()` |
| `string`, `number`, `boolean`, `object`, `array` | `asString()`, `asNumber()`, `asBoolean()`, `asObject()`, `asArray<E>()` |
| `to-string`, `to-number`, `to-boolean`, `to-color` | `convertToString()`, `convertToNumber()`, `convertToBoolean()`, `convertToColor()` |

Untyped values such as `.get('x')` are `Expression<Object?>`. Assert their type
before use with `asNumber()` and the like, or change only the static type with
`cast<R>()`.

`Expression.raw(['get', 'x'])` takes the JSON of the style spec, for anything
not covered.

## Layers on the map

A layer you added, or one from `style.layers`, is its own controller. Its setters
update the map without waiting for it, in order, so an animation can call them
every frame:

```dart
final line = style.layers['route']! as LineStyleLayer;
line.width = const .literal(4);
line.visible = false;
line.width = null; // back to the default
line.moveBelow('labels');
```

Getters return the value that is set or the default of the spec. A constant
reads back as a `Literal`:

```dart
if (line.width case Literal(:final value)) print(value);
```

Everything else reads back as an `Expression.raw`. Removing the layer or loading
a new style detaches the object; its setters then only change the object.

A property with a transition has a typed one next to it, such as
`line.colorTransition = const StyleTransition(duration: Duration(seconds: 1))`.

To show several changes in one frame on native maps, use a batch. The callback
must be synchronous:

```dart
style.batch(() {
  line.visible = true;
  style.layers.move('route', belowLayerId: 'labels');
});
```
