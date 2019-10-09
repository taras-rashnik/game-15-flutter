import 'package:flutter/material.dart';

import 'field_widget.dart';
import 'model/geometry/csize.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomepage(),
    );
  }
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var fieldSize = CSize(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.7,
    );

    var fieldWidget = new FieldWidget(fieldSize: fieldSize);

    return Scaffold(
      appBar: AppBar(
        title: Text("Game '15'"),
      ),
      body: Center(
        child: fieldWidget,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){fieldWidget.newGame();},
        tooltip: 'New game',
        child: Icon(Icons.add),
      ),
    );
  }
}

