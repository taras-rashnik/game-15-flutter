import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game15/bloc/bloc.dart';

import 'field_widget.dart';
import 'model/geometry/csize.dart';

Future main() async {
  await Future.delayed(const Duration(milliseconds: 500));
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print(screenSize);
    var length = min(screenSize.width, screenSize.height) * 0.9;
    length = max(length, 300);

    var fieldSize = CSize(length, length);

    return BlocProvider<FieldBloc>(
      builder: (context) => FieldBloc(fieldSize),
      child: Scaffold(
        backgroundColor: Colors.orange[200],
        appBar: AppBar(
          title: Text("Game '15'"),
        ),
        body: Center(
          child: FieldWidget(),
        ),
        floatingActionButton: new NewGameButton(),
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<FieldBloc>(context).dispatch(NewGameEvent());
      },
      tooltip: 'New game',
      child: Icon(Icons.add),
    );
  }
}
