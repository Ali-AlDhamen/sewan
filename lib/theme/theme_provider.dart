import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, bool>(
  (ref) => ThemeController(),
);

class ThemeController extends StateNotifier<bool> {
  late final SharedPreferences _sharedPreferences;
  ThemeController() : super(false) {
    _loadTheme();
  }

  void _loadTheme() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    state = _sharedPreferences.getBool('isDark') ?? false;
  }

  void toggleTheme() {
    state = !state;
    _sharedPreferences.setBool('isDark', state);
  }
}
