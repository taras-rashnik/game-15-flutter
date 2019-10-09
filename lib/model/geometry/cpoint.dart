class CPoint {
  double x;
  double y;

  CPoint({this.x, this.y});

  CPoint clone() => CPoint(x: x, y: y);

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