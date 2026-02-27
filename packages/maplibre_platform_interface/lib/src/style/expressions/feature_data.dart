part of 'expressions.dart';

/// Gets the feature properties object. Note that in some cases, it may be more efficient to use `["get", "property_name"]` directly.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#properties
Expression<Map<String, Object?>> properties() =>
    const Expression.fromJson(['properties']);

/// Retrieves a property value from the current feature's state. Returns null if
/// the requested property is not present on the feature's state. A feature's
/// state is not part of the GeoJSON or vector tile data, and must be set
/// programmatically on each feature. When source.promoteId is not provided,
/// features are identified by their id attribute, which must be an integer or a
/// string that can be cast to an integer. When source.promoteId is provided,
/// features are identified by their promoteId property, which may be a number,
/// string, or any primitive data type. Note that ["feature-state"] can only be
/// used with paint properties that support data-driven styling.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#feature-state
Expression<T?> featureState<T extends Object>(String propertyName) =>
    Expression.fromJson(['feature-state', propertyName]);

/// Returns the feature's simple geometry type: [Point], [LineString], or [Polygon] as [String].
/// [MultiPoint], [MultiLineString], and [MultiPolygon] are returned as [Point], [LineString], and [Polygon], respectively.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#geometry-type
Expression<String> geometryType() =>
    const Expression.fromJson(['geometry-type']);

/// Gets the feature's id, if it has one.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#id
Expression<T?> id_<T extends Object>() => const Expression.fromJson(['id']);

/// Gets the progress along a gradient line.
/// Can only be used in the [LineStyleLayer.gradient] property.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#line-progress
Expression<num> lineProgress() => const Expression.fromJson(['line-progress']);

/// Gets the value of a cluster property accumulated so far. Can only be used in the clusterProperties option of a clustered GeoJSON source.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#accumulated
Expression<T?> accumulated<T extends Object>() =>
    const Expression.fromJson(['accumulated']);
