/*
 * "DistantQueue - website": A website to explain the DistantQueue service to customers
 * Copyright (C) 2020  Salvatore Michele Rago
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';

/// The values of all the colors used in this app

class DistantQueueColors {
  static const primary = const Color(0xFF398CE8);
  static const primaryLight = const Color(0xFF72B5FF);
  static const primaryDark = const Color(0xFF125CAF);
  static const onPrimary = const Color(0xFFF5F6FA);

  static const secondary = const Color(0xFFF8F8FC);
  static const secondaryDark = const Color(0xFFE1E2E8);
  static const onSecondary = const Color(0xFF2C2C2C);

  static const surface = const Color(0xFFFFFFFF);
  static const onSurface = const Color(0xFF575F6B);

  static const background = primaryLight;
  static const onBackground = const Color(0xffffffff);

  static const error = const Color(0xffd32f2f);
  static const onError = const Color(0xffffffff);

  /*
  // V. 1
  static const primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment(0, -0.5),
    // end: Alignment.topLeft,
    end: Alignment(-1.5, -0.8),
  );*/

  // V.2
  static const primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment(0.68, 0),
    end: Alignment(-0.32, -1),
  );

  static const secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment(1.5, 2.5),
    end: Alignment(-1.5, -2.5),
  );

  static final colorScheme = ColorScheme(
    primary: primary,
    primaryVariant: primaryDark,
    secondary: secondary,
    secondaryVariant: secondaryDark,
    surface: surface,
    background: background,
    error: error,
    onPrimary: onPrimary,
    onSecondary: onSecondary,
    onSurface: onSurface,
    onBackground: onBackground,
    onError: onError,
    brightness: Brightness.dark,
  );
}

class DistantQueueThemes {
  static final popupMenuButtonTheme = PopupMenuThemeData(
    color: DistantQueueColors.secondary,
    textStyle: TextStyle(color: DistantQueueColors.onSecondary),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
