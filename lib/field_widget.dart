import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/cfield.dart';
import 'model/geometry/cpoint.dart';
import 'model/geometry/crect.dart';
import 'model/geometry/csize.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget({
    Key key,
    @required this.fieldSize,
  }) : super(key: key);

  final CSize fieldSize;

  @override
  _FieldWidgetState createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  CField field;

  @override
  void initState() {
    field = CField(
      rect: CRect(
        center: CPoint(x: 0, y: 0),
        size: widget.fieldSize,
      ),
      cols: 4,
      rows: 6,
      bricksNumber: 23,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: field.size.width,
      height: field.size.height,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: CustomPaint(
        painter: FieldPainter(field),
      ),
    );
  }
}

class FieldPainter extends CustomPainter {
  final CField field;

  FieldPainter(this.field);

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawBricks(canvas, size);
  }

  void _drawBricks(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var brick in field.bricks) {
      var center = _toScreenCoords(brick.center);

//      canvas.drawRect(
//        Rect.fromCenter(
//          center: center,
//          width: brick.width,
//          height: brick.height,
//        ),
//        paint,
//      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: center,
            width: brick.width,
            height: brick.height,
          ),
          Radius.circular(brick.cornerRadius),
        ),
        paint,
      );

      canvas.drawCircle(
        center,
        brick.width / 3,
        paint,
      );

      TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.grey[600], fontSize: 35, textBaseline: TextBaseline.alphabetic),
        text: '${brick.index + 1}',
      );

      TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tp.layout();
      tp.paint(
        canvas,
        Offset(
          center.dx - tp.width / 2,
          center.dy - tp.height / 2,
        ),
      );
    }
  }

  Offset _toScreenCoords(CPoint point) {
    return Offset(
      point.x + field.width / 2,
      point.y + field.height / 2,
    );
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightGreenAccent
      ..strokeWidth = 2;

    for (var i = 1; i < field.cols; i++) {
      final left = field.cellSize.width * i;

      canvas.drawLine(
        Offset(left, 0),
        Offset(left, field.height),
        paint,
      );
    }

    for (var i = 1; i < field.rows; i++) {
      var top = field.cellSize.height * i;

      canvas.drawLine(
        Offset(0, top),
        Offset(field.width, top),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return field != (oldDelegate as FieldPainter).field;
  }
}
