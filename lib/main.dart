import 'package:flutter/material.dart';
import 'package:shakespeare_sonnet/bloc/theme_bloc.dart';

void main() => runApp(MyApp());

final ThemeBloc themeBloc = ThemeBloc();

class MyApp extends StatelessWidget {
  Brightness brightness;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: themeBloc.theme,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue, brightness: (snapshot.data ? Brightness.dark :Brightness.light)),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        )
    );
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
    List<String> lines = [
      "From fairest creatures we desire increase,",
      "That thereby beauty's rose might never die,",
      "But as the riper should by time decease,",
      "His tender heir might bear his memory:",
      "But thou contracted to thine own bright eyes,",
      "Feed'st thy light's flame with self-substantial fuel,",
      "Making a famine where abundance lies,",
      "Thy self thy foe, to thy sweet self too cruel:",
      "Thou that art now the world's fresh ornament,",
      "And only herald to the gaudy spring,",
      "Within thine own bud buriest thy content,",
      "And tender churl mak'st waste in niggarding:",
      "  Pity the world, or else this glutton be,",
      "  To eat the world's due, by the grave and thee."
    ];

    List<Widget> lineText = lines
        .map<Widget>(
            (line) => Text(line, style: TextStyle(height: 1.5, fontSize: 15.5)))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lineText,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () => themeBloc.themeChange.add(true),
      ),
    );
  }
}

class Sonnet {
  String title;
  String author;
  List<String> lines;
  String linecount;

  Sonnet({this.title, this.author, this.lines, this.linecount});

  Sonnet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    lines = json['lines'].cast<String>();
    linecount = json['linecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['lines'] = this.lines;
    data['linecount'] = this.linecount;
    return data;
  }
}
