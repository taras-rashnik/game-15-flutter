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
    final top = field.top;

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
