import 'package:flutter_test/flutter_test.dart';
import 'package:game15/model/cfield.dart';
import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/crect.dart';
import 'package:game15/model/geometry/csize.dart';

main() {
  test('tect CField equiality', () {
    var field = CField(
      rect: CRect(
        center: CPoint(x: 0, y: 0),
        size: CSize(width: 200, height: 300),
      ),
      cols: 4,
      rows: 6,
      bricksNumber: 23,
    );

    var clonedField = field.clone();
    expect(clonedField, equals(field));

    //
    var newBrick = clonedField.bricks[2];
    newBrick.rect.center.x += 100;
    newBrick.rect.center.y += 100;
    expect(clonedField, isNot(equals(field)));
  });
}
