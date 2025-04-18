import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode theme) {
    emit(theme);
    print(theme);
  }

  // Implement fromJson
  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    final themeString = json['theme'] as String;
    print(themeString);
    switch (themeString) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light;
    }
  }

  // Implement toJson
  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {
      'theme': state == ThemeMode.dark ? 'dark' : 'light',
    };
  }
}