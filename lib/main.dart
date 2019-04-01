import 'package:flutter/material.dart';
import 'package:shakespeare_sonnet/bloc/theme_bloc.dart';
import 'package:shakespeare_sonnet/bloc/sonnet_bloc.dart';
import 'package:shakespeare_sonnet/resources/get_sonnet.dart';
import 'dart:math';

void main() => runApp(MyApp());

final ThemeBloc themeBloc = ThemeBloc();
final SonnetAPI sonnetAPI = new SonnetAPI();
final SonnetBloc sonnetBloc = SonnetBloc(sonnetAPI);

Random rnd = new Random();
int min = 1, max = 155;

class MyApp extends StatelessWidget {
  Brightness brightness;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: themeBloc.theme,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
            MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  brightness:
                      (snapshot.data ? Brightness.dark : Brightness.light)),
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: StreamBuilder<List<String>>(
          stream: sonnetBloc.sonnet,
          initialData: ["Hello", "Welcome to Sonnets!"],
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data
                        .map<Widget>((line) => Text(line,
                            style: TextStyle(height: 1.5, fontSize: 15.5)))
                        .toList(),
                  ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => themeBloc.themeChange.add(false),
            tooltip: 'Theme',
            child: Icon(Icons.access_alarm),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () =>
                sonnetBloc.onSonnetChanged.add(min + rnd.nextInt(max - min)),
            tooltip: 'Random Sonnet',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
