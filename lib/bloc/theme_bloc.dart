import 'dart:async';
import 'package:rxdart/subjects.dart';

class ThemeBloc {
  final Sink<bool> themeChange;
  final Stream<bool> theme;
  factory ThemeBloc() {
    final tChange = new PublishSubject<bool>();
    final theme = tChange.scan<bool>((acc, curr, i) => (curr == acc)).startWith(true);
    return ThemeBloc._(tChange, theme);
  }
  ThemeBloc._(this.themeChange, this.theme);
  void dispose() => themeChange.close();
}
