import 'package:flutter/material.dart';
import 'bloc/theme_bloc.dart';
import 'bloc/sonnet_bloc.dart';
import 'data/get_sonnet.dart';
import 'dart:math';

void main() => runApp(App());

final ThemeBloc themeBloc = ThemeBloc();
final SonnetBloc sonnetBloc = SonnetBloc(new SonnetAPI());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return StreamBuilder<bool>(
      stream: themeBloc.theme,
      initialData: true,
      builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot) => MaterialApp(
        theme: ThemeData(
          fontFamily: "Lora",
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
  int _sonnet = 0;
  bool _lineCount = false;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_sonnet == 0 ? "" : 'Sonnet $_sonnet')),
        elevation: 0,
        brightness: Theme.of(ctx).brightness,
        backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
        textTheme: Theme.of(ctx).textTheme,
        iconTheme: Theme.of(ctx).iconTheme,
        actions: <Widget>[
          IconButton(
            onPressed: () => setState(() {
              if (_sonnet != 0) _lineCount = !_lineCount;
            }),
            icon: Icon(Icons.format_list_numbered),
          ),
          IconButton(
            onPressed: () => themeBloc.themeChange.add(false),
            icon: Icon(Icons.brightness_3),
          ),
          IconButton(
            onPressed: () {
              int rand = 1 + (new Random()).nextInt(154);
              sonnetBloc.sonnetChange.add(rand);
              setState(() {
                _sonnet = rand;
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: StreamBuilder<List<String>>(
          stream: sonnetBloc.sonnet,
          initialData: [""],
          builder: (BuildContext ctx, AsyncSnapshot<List<String>> snapshot) =>
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: new List<Widget>.from([
                SizedBox(width: 10),
                Text(
                  (snapshot.data[0] == "" ? "Refresh for a Shakespeare Sonnet :)" : '"${snapshot.data[0].replaceAll(new RegExp(r"(,$|;$)"), '')}..."'),
                  style: TextStyle(
                    height: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
              ])..addAll(snapshot.data.map<Widget>((line) => Text(
                  _lineCount ? '[${snapshot.data.indexOf(line) + 1}] $line' : line,
                  style: TextStyle(height: 1.5, fontSize: 14),
                )).toList()),
            )
        ),
      ),
    );
  }
}
