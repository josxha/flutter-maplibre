part of 'expression.dart';

/// Expressions on numbers.
///
/// {@category Style}
extension NumExpression on Expression<num> {
  /// The sum of this and [other] (spec: `+`).
  Expression<num> operator +(Expression<num> other) =>
      _call('+', [this, other]);

  /// This minus [other] (spec: `-`).
  Expression<num> operator -(Expression<num> other) =>
      _call('-', [this, other]);

  /// The product of this and [other] (spec: `*`).
  Expression<num> operator *(Expression<num> other) =>
      _call('*', [this, other]);

  /// This divided by [other] (spec: `/`).
  Expression<num> operator /(Expression<num> other) =>
      _call('/', [this, other]);

  /// The remainder of this divided by [other] (spec: `%`).
  Expression<num> operator %(Expression<num> other) =>
      _call('%', [this, other]);

  /// This negated (spec: `-`).
  Expression<num> operator -() => _call('-', [this]);

  /// Whether this is greater than [other] (spec: `>`).
  Expression<bool> operator >(Expression<num> other) =>
      _call('>', [this, other]);

  /// Whether this is less than [other] (spec: `<`).
  Expression<bool> operator <(Expression<num> other) =>
      _call('<', [this, other]);

  /// Whether this is greater than or equal to [other] (spec: `>=`).
  Expression<bool> operator >=(Expression<num> other) =>
      _call('>=', [this, other]);

  /// Whether this is less than or equal to [other] (spec: `<=`).
  Expression<bool> operator <=(Expression<num> other) =>
      _call('<=', [this, other]);

  /// This to the power of [exponent] (spec: `^`).
  Expression<num> pow(Expression<num> exponent) => _call('^', [this, exponent]);

  /// The square root (spec: `sqrt`).
  Expression<num> sqrt() => _call('sqrt', [this]);

  /// The base-ten logarithm (spec: `log10`).
  Expression<num> log10() => _call('log10', [this]);

  /// The natural logarithm (spec: `ln`).
  Expression<num> ln() => _call('ln', [this]);

  /// The base-two logarithm (spec: `log2`).
  Expression<num> log2() => _call('log2', [this]);

  /// The sine (spec: `sin`).
  Expression<num> sin() => _call('sin', [this]);

  /// The cosine (spec: `cos`).
  Expression<num> cos() => _call('cos', [this]);

  /// The tangent (spec: `tan`).
  Expression<num> tan() => _call('tan', [this]);

  /// The arcsine (spec: `asin`).
  Expression<num> asin() => _call('asin', [this]);

  /// The arccosine (spec: `acos`).
  Expression<num> acos() => _call('acos', [this]);

  /// The arctangent (spec: `atan`).
  Expression<num> atan() => _call('atan', [this]);

  /// Rounded to the nearest integer, halves away from zero (spec: `round`).
  Expression<num> round() => _call('round', [this]);

  /// The absolute value (spec: `abs`).
  Expression<num> abs() => _call('abs', [this]);

  /// The smallest integer not below this (spec: `ceil`).
  Expression<num> ceil() => _call('ceil', [this]);

  /// The largest integer not above this (spec: `floor`).
  Expression<num> floor() => _call('floor', [this]);

  /// This number as a string in a locale-dependent format (spec:
  /// `number-format`).
  Expression<String> numberFormat({
    Expression<String>? locale,
    Expression<String>? currency,
    Expression<num>? minFractionDigits,
    Expression<num>? maxFractionDigits,
  }) => Call([
    'number-format',
    toJson(),
    {
      if (locale != null) 'locale': locale.toJson(),
      if (currency != null) 'currency': currency.toJson(),
      if (minFractionDigits != null)
        'min-fraction-digits': minFractionDigits.toJson(),
      if (maxFractionDigits != null)
        'max-fraction-digits': maxFractionDigits.toJson(),
    },
  ]);
}

/// Expressions on strings.
///
/// {@category Style}
extension StringExpression on Expression<String> {
  /// This and [other] joined (spec: `concat`).
  Expression<String> operator +(Expression<String> other) =>
      _call('concat', [this, other]);

  /// Whether this sorts after [other] (spec: `>`).
  Expression<bool> operator >(Expression<String> other) =>
      _call('>', [this, other]);

  /// Whether this sorts before [other] (spec: `<`).
  Expression<bool> operator <(Expression<String> other) =>
      _call('<', [this, other]);

  /// Whether this sorts after or equal to [other] (spec: `>=`).
  Expression<bool> operator >=(Expression<String> other) =>
      _call('>=', [this, other]);

  /// Whether this sorts before or equal to [other] (spec: `<=`).
  Expression<bool> operator <=(Expression<String> other) =>
      _call('<=', [this, other]);

  /// Whether this contains [substring] (spec: `in`).
  Expression<bool> contains(Expression<String> substring) =>
      _call('in', [substring, this]);

  /// The position of the first [substring] at or after [from], or -1 (spec:
  /// `index-of`).
  Expression<num> indexOf(
    Expression<String> substring, {
    Expression<num>? from,
  }) => _call('index-of', [substring, this, ?from]);

  /// The part of this from [start], up to [end] if given (spec: `slice`).
  Expression<String> slice(Expression<num> start, [Expression<num>? end]) =>
      _call('slice', [this, start, ?end]);

  /// The length in UTF-16 code units (spec: `length`).
  Expression<num> length() => _call('length', [this]);

  /// This in uppercase (spec: `upcase`).
  Expression<String> upcase() => _call('upcase', [this]);

  /// This in lowercase (spec: `downcase`).
  Expression<String> downcase() => _call('downcase', [this]);

  /// The substrings between the occurrences of [separator] (spec: `split`).
  Expression<List<String>> split(Expression<String> separator) =>
      _call('split', [this, separator]);

  /// Whether the map can render this string's script (spec:
  /// `is-supported-script`).
  Expression<bool> isSupportedScript() => _call('is-supported-script', [this]);
}

/// Expressions on lists.
///
/// {@category Style}
extension ListExpression<E> on Expression<List<E>> {
  /// The item at [index] (spec: `at`).
  Expression<E> at(Expression<num> index) => _call('at', [index, this]);

  /// Whether this contains [item] (spec: `in`).
  Expression<bool> contains(Expression<E> item) => _call('in', [item, this]);

  /// The position of the first [item] at or after [from], or -1 (spec:
  /// `index-of`).
  Expression<num> indexOf(Expression<E> item, {Expression<num>? from}) =>
      _call('index-of', [item, this, ?from]);

  /// The items from [start], up to [end] if given (spec: `slice`).
  Expression<List<E>> slice(Expression<num> start, [Expression<num>? end]) =>
      _call('slice', [this, start, ?end]);

  /// The number of items (spec: `length`).
  Expression<num> length() => _call('length', [this]);

  /// The items joined by [separator] (spec: `join`).
  Expression<String> join(Expression<String> separator) =>
      _call('join', [this, separator]);
}

/// Expressions on booleans.
///
/// {@category Style}
extension BoolExpression on Expression<bool> {
  /// The opposite of this (spec: `!`).
  Expression<bool> not() => _call('!', [this]);
}

/// Expressions on colors.
///
/// {@category Style}
extension ColorExpression on Expression<Color> {
  /// The red, green, blue and alpha components of this color (spec:
  /// `to-rgba`).
  Expression<List<num>> toRgba() => _call('to-rgba', [this]);
}

/// Expressions on collators.
///
/// {@category Style}
extension CollatorExpression on Expression<Collator> {
  /// The IETF language tag of the locale of this collator (spec:
  /// `resolved-locale`).
  Expression<String> resolvedLocale() => _call('resolved-locale', [this]);
}
