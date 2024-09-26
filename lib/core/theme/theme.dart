import 'package:client/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete
        .backgroundColor, // copywith is specified here to enable modifying the properties of dart theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      // enabled border allows to apply the styles specified even if the field is not focused
      enabledBorder: _border(Pallete.borderColor),
      // focused border specifies the styles to be applied on focus
      focusedBorder: _border(Pallete.gradient2),
    ),
  );
}
