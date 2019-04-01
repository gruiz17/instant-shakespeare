import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../models/sonnet.dart';
import '../data/get_sonnet.dart';

class SonnetBloc {
  final Sink<int> sonnetChange;
  final Stream<List<String>> sonnet;
  factory SonnetBloc(SonnetAPI api) {
    final sChange = new PublishSubject<int>();
    final sonnet = sChange
        .flatMap<Sonnet>((sNumber) => _get(sNumber, api))
        .map<List<String>>((sonnet) => sonnet.lines);
    return SonnetBloc._(sChange, sonnet);
  }
  SonnetBloc._(this.sonnetChange, this.sonnet);
  void dispose() => sonnetChange.close();
}

Stream<Sonnet> _get(int sonnetNumber, SonnetAPI api) async* {
  yield await api.getSonnet(sonnetNumber);
}
