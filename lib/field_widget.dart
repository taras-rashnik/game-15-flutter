import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game15/bloc/bloc.dart';
import 'package:game15/model/cbrick.dart';

import 'model/cfield.dart';
import 'model/geometry/cpoint.dart';
import 'model/geometry/crect.dart';
import 'model/geometry/csize.dart';

class FieldWidget extends StatefulWidget {
  FieldWidget({Key key}) : super(key: key);

  @override
  _FieldWidgetState createState() {
    return _FieldWidgetState();
  }
}

class _FieldWidgetState extends State<FieldWidget> {

  @override
  Widget build(BuildContext context) {
    var fieldBloc = BlocProvider.of<FieldBloc>(context);

    return GestureDetector(
      onPanStart: (details) {
        fieldBloc.dispatch(SelectBrickEvent(details.localPosition.dx, details.localPosition.dy));
      },
      onPanUpdate: (details) {
        fieldBloc.dispatch(MoveBrickEvent(details.delta.dx, details.delta.dy));
      },
      onPanEnd: (details) {
        fieldBloc.dispatch(DeselectBrickEvent());
      },
      child: BlocBuilder<FieldBloc, FieldState>(
        builder: (context, fieldState) {
          return Container(
            width: fieldState.field.size.width,
            height: fieldState.field.size.height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange[400], width: 2),
              color: Colors.deepOrange[100],
            ),
            child: CustomPaint(
              painter: FieldPainter(fieldState.field),
            ),
          );
        },
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
    var gradient2 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8),
        Color.fromARGB(0xFF, 0xC0, 0xC0, 0xC0)
      ],
    );

    var gradient1 = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromARGB(0xFF, 0xB3, 0xB3, 0xB3),
        Color.fromARGB(0xFF, 0xFF, 0xFF, 0xFF)
      ],
    );

    final paint3 = Paint()
      ..color = Color.fromARGB(0xFF, 0xB3, 0xB3, 0xB3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

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

      var rect = Rect.fromCenter(
        center: center,
        width: brick.width,
        height: brick.height,
      );

      final paint2 = Paint()..shader = gradient2.createShader(rect);

      var rRect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(brick.cornerRadius),
      );

      canvas.drawRRect(rRect, paint2);

      canvas.drawRRect(rRect, paint3);

      final paint1 = Paint()..shader = gradient1.createShader(rect);

      canvas.drawCircle(
        center,
        brick.width / 2.5,
        paint1,
      );

      TextSpan span = new TextSpan(
        style: new TextStyle(
            color: Colors.red,
            fontSize: 40,
            textBaseline: TextBaseline.alphabetic),
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
      ..color = Colors.deepOrange[300]
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
