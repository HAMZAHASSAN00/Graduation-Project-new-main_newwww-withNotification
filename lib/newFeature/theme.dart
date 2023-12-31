import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ThemePage extends ConsumerWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(themeNotifierProvider);

    return Scaffold(
        appBar: AppBar(title: Text("Dynamic Theme")),
        body: Column(
          children: [
            _singleTile("Dark Theme",   ThemeMode.dark, notifier),
            _singleTile("Light Theme",  ThemeMode.light, notifier),
            _singleTile("System Theme", ThemeMode.system, notifier),
          ],
        ));
  }

  Widget _singleTile(String title, ThemeMode mode, ThemeNotifier notifier) {
    return RadioListTile<ThemeMode>(
        value: mode,
        title: Text(title),
        groupValue: notifier.themeMode,
        onChanged: (val) {
          if (val != null) notifier.setTheme(val);
        });
  }
}
class ThemeNotifier extends ChangeNotifier {
  // Define your default thememode here
  ThemeMode themeMode = ThemeMode.light;
  SharedPreferences? prefs;

  ThemeNotifier() {
    _init();
  }

  _init() async {
    // Get the stored theme from shared preferences
    prefs = await SharedPreferences.getInstance();

    int _theme = prefs?.getInt("theme") ?? themeMode.index;
    themeMode = ThemeMode.values[_theme];
    notifyListeners();
  }

  setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
    // Save the selected theme using shared preferences
    prefs?.setInt("theme", mode.index);
  }
}

final themeNotifierProvider =
ChangeNotifierProvider<ThemeNotifier>((_) => ThemeNotifier());