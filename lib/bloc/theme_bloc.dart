import 'dart:async';
import 'package:rxdart/subjects.dart';

class ThemeBloc {
  final Sink<bool> themeChange;
  final Stream<bool> theme;
  factory ThemeBloc() {
    final themeChange = new PublishSubject<bool>();
    final theme = themeChange.scan<bool>((acc, curr, i) => (curr == acc)).startWith(true);
    return ThemeBloc._(themeChange, theme);
  }
  ThemeBloc._(this.themeChange, this.theme);
  void dispose() => themeChange.close();
}
