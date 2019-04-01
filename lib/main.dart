import 'package:flutter/material.dart';
import 'bloc/theme_bloc.dart';
import 'bloc/sonnet_bloc.dart';
import 'data/get_sonnet.dart';
import 'dart:math';

void main() => runApp(App());

final ThemeBloc themeBloc = ThemeBloc();
final SonnetAPI sonnetAPI = new SonnetAPI();
final SonnetBloc sonnetBloc = SonnetBloc(sonnetAPI);

class App extends StatelessWidget {
  Brightness brightness;
  @override
  Widget build(BuildContext ctx) {
    return StreamBuilder<bool>(
      stream: themeBloc.theme,
      initialData: true,
      builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot) => MaterialApp(
            theme: ThemeData(
              brightness: (snapshot.data ? Brightness.dark : Brightness.light),
            ),
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
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonnet 1"),
        elevation: 0.0,
        backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
        textTheme: Theme.of(ctx).textTheme,
        iconTheme: Theme.of(ctx).iconTheme,
        actions: <Widget>[
          IconButton(
            onPressed: () => print("lol"),
            icon: Icon(Icons.format_list_numbered),
          ),
          IconButton(
            onPressed: () => themeBloc.themeChange.add(false),
            icon: Icon(Icons.brightness_3),
          ),
          IconButton(
            onPressed: () =>
                sonnetBloc.sonnetChange.add(1 + (new Random()).nextInt(154)),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: StreamBuilder<List<String>>(
          stream: sonnetBloc.sonnet,
          initialData: ["Click 'Random'!"],
          builder: (BuildContext ctx, AsyncSnapshot<List<String>> snapshot) =>
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: new List<Widget>.from([
                  SizedBox(width: 10.0),
                  Text('"${snapshot.data[0].replaceAll(new RegExp(r"(,$|;$)"), '')}..."',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                ])
                  ..addAll(snapshot.data
                      .map<Widget>((line) => Text(line,
                          style: TextStyle(height: 1.5, fontSize: 15.0)))
                      .toList()),
              ),
        ),
      ),
    );
  }
}
