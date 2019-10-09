class CSize{
  final double width;
  final double height;

  CSize({this.width, this.height});

  CSize clone() => CSize(width: width, height: height);

  @override
  bool operator ==(other) {
    if (other is! CSize) return false;
    final CSize typedOther = other;
    return width == typedOther.width && height == typedOther.height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;

  @override
  String toString() => 'CSize(${width?.toStringAsFixed(1)}, ${height?.toStringAsFixed(1)})';
}