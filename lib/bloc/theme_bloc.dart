import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:shakespeare_sonnet/bloc/events.dart';

class ThemeBloc {
  final Sink<ThemeEvent> themeChange; 
  final Stream<String> theme;
  factory ThemeBloc() {
    final onThemeChange = new PublishSubject<ThemeEvent>();
    final theme =
        onThemeChange
        .map<String>((event) => (event is DarkModeEvent ? "dark" : "light"))
        .startWith("dark");
    return ThemeBloc._(onThemeChange, theme);
  }
  ThemeBloc._(this.themeChange, this.theme);
  void dispose() {
    themeChange.close();
  }
}
