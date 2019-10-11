import 'dart:math' as Math;

class CPoint {
  final double x;
  final double y;

  const CPoint(this.x, this.y);

  factory CPoint.origin() => CPoint(0, 0);

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
  String toString() =>
      'CPoint(${x?.toStringAsFixed(1)}, ${y?.toStringAsFixed(1)})';

  CPoint rotateRight90() => CPoint(y, -x);

  CPoint rotateLeft90() => CPoint(-y, x);

  CPoint rotateRight45() {
    return CPoint(
      x * cos45 - y * sin45,
      x * sin45 + y * cos45,
    );
  }

  CPoint rotateLeft45() {
    return CPoint(
      x * cos45 + y * sin45,
      -x * sin45 + y * cos45,
    );
  }
}

final sin45 = Math.sin(Math.pi / 4);
final cos45 = Math.cos(Math.pi / 4);
