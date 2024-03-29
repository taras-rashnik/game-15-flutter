class CVector {
  final double x;
  final double y;

  const CVector(this.x, this.y);

  @override
  bool operator ==(other) {
    if (other is! CVector) return false;
    final CVector typedOther = other;
    return x == typedOther.x && y == typedOther.y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'CVector(${x?.toStringAsFixed(1)}, ${y?.toStringAsFixed(1)})';
}
