import 'package:flutter/material.dart';
import 'package:shakespeare_sonnet/bloc/theme_bloc.dart';
import 'package:shakespeare_sonnet/bloc/sonnet_bloc.dart';
import 'package:shakespeare_sonnet/resources/get_sonnet.dart';
import 'dart:math';

void main() => runApp(App());

final ThemeBloc themeBloc = ThemeBloc();
final SonnetAPI sonnetAPI = new SonnetAPI();
final SonnetBloc sonnetBloc = SonnetBloc(sonnetAPI);

Random rnd = new Random();

class App extends StatelessWidget {
  Brightness brightness;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: themeBloc.theme,
      initialData: true,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
        MaterialApp(
          theme: ThemeData(brightness: (snapshot.data ? Brightness.dark : Brightness.light)),
          home: Home(),
        ),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: StreamBuilder<List<String>>(
          stream: sonnetBloc.sonnet,
          initialData: ["Hello", "Welcome to Sonnets!"],
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) =>
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data.map<Widget>((line) => 
                Text(line, style: TextStyle(height: 1.5, fontSize: 15.5))).toList(),
            ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => themeBloc.themeChange.add(false),
            child: Icon(Icons.access_alarm),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () => sonnetBloc.onSonnetChanged.add(1 + rnd.nextInt(154)),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
