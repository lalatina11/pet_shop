import 'package:flutter/material.dart';
import 'package:pet_shop/src/lib/cubits/theme/theme_state.dart';

class WidgetColorGenerator {
  Color getPrimaryColor() {
    return Colors.deepOrange;
  }

  Color getButtonText({required ThemeState state}) {
    if (state == ThemeState.dark) {
      return Colors.black;
    }
    return Colors.white;
  }
}
