class CPoint {
  final double x;
  final double y;

  const CPoint(this.x, this.y);

  factory CPoint.origin() => CPoint(0, 0);

  CPoint clone() => CPoint(x, y);

  CPoint shift(double dx, double dy) => CPoint(x + dx, y + dy);

  @override
  bool operator ==(other) {
    if (other is! CPoint) return false;
    final CPoint typedOther = other;
    return x == typedOther.x && y == typedOther.y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'CPoint(${x?.toStringAsFixed(1)}, ${y?.toStringAsFixed(1)})';
}