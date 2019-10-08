import 'package:flutter/material.dart';

import 'geometry/csize.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fieldSize.width,
      height: widget.fieldSize.height,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      child: Text(
        'Field is here',
      ),
    );
  }
}

