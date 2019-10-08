import 'package:flutter/material.dart';
import 'package:game15/geometry/cpoint.dart';
import 'package:game15/geometry/crect.dart';

import 'geometry/csize.dart';
import 'model/cfield.dart';

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
      child: Text(
        'Field is here',
      ),
    );
  }
}
