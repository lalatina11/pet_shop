import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  SharedPreferences sharedPreferences;

  ThemeCubit({required this.sharedPreferences}) : super(ThemeState.light);

  void switchTheme() {
    String? savedTheme = sharedPreferences.getString("theme");
    if (savedTheme == "ThemeState.dark") {
      return setThemeMode(ThemeState.light);
    }
    return setThemeMode(ThemeState.dark);
  }

  void setThemeMode(ThemeState state) {
    emit(state);
    saveTheme(state);
  }

  void saveTheme(ThemeState state) {
    sharedPreferences.setString("theme", state.toString());
  }

  void loadTheme() {
    String? savedTheme = sharedPreferences.getString("theme");
    if (savedTheme == "ThemeState.dark") {
      return emit(ThemeState.dark);
    }
    return emit(ThemeState.dark);
  }
}
