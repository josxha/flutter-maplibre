part of 'expressions.dart';

/// Returns true if the [input] string is expected to render legibly.
/// Returns `false` if the [input] string contains sections that cannot be
/// rendered without potential loss of meaning (e.g. Indic scripts that require
/// complex text shaping, or right-to-left scripts if the mapbox-gl-rtl-text
/// plugin is not in use in MapLibre GL JS).
///
/// https://maplibre.org/maplibre-style-spec/expressions/#is-supported-script
Expression<bool> isSupportedScript(Expression<String> input) =>
    Expression.fromJson(['is-supported-script', input]);

/// Returns the input string converted to uppercase. Follows the Unicode Default Case Conversion algorithm and the locale-insensitive case mappings in the Unicode Character Database.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#upcase
Expression<String> upcase(Expression<String> input) =>
    Expression.fromJson(['upcase', input]);

/// Returns the input string converted to lowercase. Follows the Unicode Default Case Conversion algorithm and the locale-insensitive case mappings in the Unicode Character Database.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#downcase
Expression<String> downcase(Expression<String> input) =>
    Expression.fromJson(['downcase', input]);

/// Returns a string consisting of the concatenation of the inputs. Each input
/// is converted to a string as if by [toString].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#concat
Expression<String> concat(List<Expression> inputs) =>
    Expression.fromJson(['concat', ...inputs]);

/// Returns the IETF language tag of the locale being used by the provided
/// [collator]. This can be used to determine the default system locale, or to
/// determine if a requested locale was successfully loaded.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#resolved-locale
Expression<String> resolvedLocale(Expression collator) =>
    Expression.fromJson(['resolved-locale', collator]);

/// Returns an array of substrings formed by splitting an input string by a
/// separator string.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#split
Expression<List<String>> split_(
  Expression<String> input,
  Expression<String> separator,
) => Expression.fromJson(['split', input, separator]);

/// Returns a string formed by concatenating the elements of the input array,
/// inserting a separator between each element.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#join
Expression<String> join(List<Object> input, Object separator) {
  assert(
    input.every((element) => element is Expression || element is String),
    'Input must be a list of Expressions or Strings',
  );
  assert(
    separator is Expression || separator is String,
    'Separator must be an Expression or a String',
  );
  return Expression.fromJson(['join', input, separator]);
}
