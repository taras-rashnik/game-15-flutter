import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game15/bloc/bloc.dart';

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
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var fieldSize = CSize(
      screenSize.width * 0.9,
      screenSize.height * 0.7,
    );

    return BlocProvider<FieldBloc>(
      builder: (context) => FieldBloc(fieldSize),
      child: Scaffold(
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
