class CSize {
  final double width;
  final double height;

  const CSize(this.width, this.height);

  factory CSize.zero() => CSize(0, 0);

  CSize clone() => CSize(width, height);

  CSize operator *(double scale) => CSize(width * scale, height * scale);

  @override
  bool operator ==(other) {
    if (other is! CSize) return false;
    final CSize typedOther = other;
    return width == typedOther.width && height == typedOther.height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;

  @override
  String toString() =>
      'CSize(${width?.toStringAsFixed(1)}, ${height?.toStringAsFixed(1)})';
}
