import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:shakespeare_sonnet/models/sonnet.dart';
import 'package:shakespeare_sonnet/resources/get_sonnet.dart';

class SonnetBloc {
  final Sink<int> onSonnetChanged;
  final Stream<List<String>> sonnet;

  factory SonnetBloc(SonnetAPI sonnetAPI) {
    final onSonnetChanged = new PublishSubject<int>();
    final sonnet = onSonnetChanged.flatMap<Sonnet>(
        (sonnetNumber) => _getSonnet(sonnetNumber, sonnetAPI))
        .map<List<String>>((sonnet) => sonnet.lines)
        .startWith(["Welcome to Sonnet!"]);
    return SonnetBloc._(onSonnetChanged, sonnet);
  }
  SonnetBloc._(this.onSonnetChanged, this.sonnet);
  void dispose() {
    onSonnetChanged.close();
  }
}

Stream<Sonnet> _getSonnet(int sonnetNumber, SonnetAPI api) async* {
  final result = await api.getSonnet(sonnetNumber);
  yield result;
}
