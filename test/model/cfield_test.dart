import 'package:flutter_test/flutter_test.dart';
import 'package:game15/model/cfield.dart';
import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/crect.dart';
import 'package:game15/model/geometry/csize.dart';

main() {
  test('tect CField equiality', () {
    var field = CField(
      rect: CRect(
        center: CPoint.origin(),
        size: CSize(200, 300),
      ),
      cols: 4,
      rows: 6,
      bricksNumber: 23,
    );

    var clonedField = field.clone();
    expect(clonedField, equals(field));

    //
    var shiftedField = field.shiftBrick(2, 100, 0);
    expect(shiftedField, isNot(equals(field)));
  });
}
