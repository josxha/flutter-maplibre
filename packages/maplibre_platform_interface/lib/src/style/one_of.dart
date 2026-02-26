
/// Create a union type with two possible types [T1] and [T2].
extension type const OneOf2<T1, T2>._(dynamic _) {
  /// Create a new instance of [OneOf2] with a value of type [T1].
  const OneOf2.t1(T1 value) : this._(value);

  /// Create a new instance of [OneOf2] with a value of type [T2].
  const OneOf2.t2(T2 value) : this._(value);

  /// Get the value as type [T1].
  T1 get asT1 => this as T1;

  /// Get the value as type [T2].
  T2 get asT2 => this as T2;
}

/// Create a union type with three possible types [T1], [T2] and [T3].
extension type const OneOf3<T1, T2, T3>._(dynamic _) {
  /// Create a new instance of [OneOf3] with a value of type [T1].
  const OneOf3.t1(T1 value) : this._(value);

  /// Create a new instance of [OneOf3] with a value of type [T2].
  const OneOf3.t2(T2 value) : this._(value);

  /// Create a new instance of [OneOf3] with a value of type [T3].
  const OneOf3.t3(T3 value) : this._(value);

  /// Get the value as type [T1].
  T1 get asT1 => this as T1;

  /// Get the value as type [T2].
  T2 get asT2 => this as T2;

  /// Get the value as type [T3].
  T3 get asT3 => this as T3;
}

/// Create a union type with three possible types [T1], [T2], [T3] and [T4].
extension type const OneOf4<T1, T2, T3, T4>._(dynamic _) {
  /// Create a new instance of [OneOf4] with a value of type [T1].
  const OneOf4.t1(T1 value) : this._(value);

  /// Create a new instance of [OneOf4] with a value of type [T2].
  const OneOf4.t2(T2 value) : this._(value);

  /// Create a new instance of [OneOf4] with a value of type [T3].
  const OneOf4.t3(T3 value) : this._(value);

  /// Create a new instance of [OneOf4] with a value of type [T4].
  const OneOf4.t4(T4 value) : this._(value);

  /// Get the value as type [T1].
  T1 get asT1 => this as T1;

  /// Get the value as type [T2].
  T2 get asT2 => this as T2;

  /// Get the value as type [T3].
  T3 get asT3 => this as T3;

  /// Get the value as type [T4].
  T4 get asT4 => this as T4;
}

/// Create a union type with three possible types : [String], [double], [bool],
/// [Map<String, Object?>] and [List<Object?>].
extension type const OneOf._(dynamic _) {
  /// Create a new instance of [OneOf] with a value of type [String].
  const OneOf.string(String value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type [double].
  const OneOf.double(double value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type [bool].
  // ignore: avoid_positional_boolean_parameters
  const OneOf.bool(bool value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type
  /// [Map<String, Object?>].
  const OneOf.map(Map<String, Object?> value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type [List<Object?>].
  const OneOf.list(List<Object?> value) : this._(value);

  /// Get the value as type [String].
  String get asString => this as String;

  /// Get the value as type [double].
  double get asDouble => this as double;

  /// Get the value as type [bool].
  bool get asBool => this as bool;

  /// Get the value as type [Map<String, Object?>].
  Map<String, Object?> get asMap => this as Map<String, Object?>;

  /// Get the value as type [List<Object?>].
  List<Object?> get asList => this as List<Object?>;
}
