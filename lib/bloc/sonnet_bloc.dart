import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../models/sonnet.dart';
import '../resources/get_sonnet.dart';

class SonnetBloc {
  final Sink<int> onSonnetChanged;
  final Stream<List<String>> sonnet;
  factory SonnetBloc(SonnetAPI sonnetAPI) {
    final onSonnetChanged = new PublishSubject<int>();
    final sonnet = onSonnetChanged.flatMap<Sonnet>((sNumber) => _getSonnet(sNumber, sonnetAPI))
      .map<List<String>>((sonnet) => sonnet.lines);
    return SonnetBloc._(onSonnetChanged, sonnet);
  }
  SonnetBloc._(this.onSonnetChanged, this.sonnet);
  void dispose() {
    onSonnetChanged.close();
  }
}
Stream<Sonnet> _getSonnet(int sonnetNumber, SonnetAPI api) async* {
  yield await api.getSonnet(sonnetNumber);
}
