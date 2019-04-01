import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../models/sonnet.dart';
import '../data/get_sonnet.dart';

class SonnetBloc {
  final Sink<int> sonnetChange;
  final Stream<List<String>> sonnet;
  factory SonnetBloc(SonnetAPI sonnetAPI) {
    final sonnetChange = new PublishSubject<int>();
    final sonnet = sonnetChange.flatMap<Sonnet>((sNumber) => _get(sNumber, sonnetAPI))
      .map<List<String>>((sonnet) => sonnet.lines);
    return SonnetBloc._(sonnetChange, sonnet);
  }
  SonnetBloc._(this.sonnetChange, this.sonnet);
  void dispose() => sonnetChange.close();
}
Stream<Sonnet> _get(int sonnetNumber, SonnetAPI api) async* {
  yield await api.getSonnet(sonnetNumber);
}
