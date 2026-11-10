import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF710014);
const Color secondaryColor = Color(0xFFB38F6F);
const Color tertiaryColor = Color(0xFF161616);
const Color onPrimaryColor = Color(0xFFB38F6F);
const Color onSecondaryColor = Color(0xFF161616);
const Color onTertiaryColor = Color(0xFFEFEFEF);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    surface: primaryColor,
    onSurface: onPrimaryColor,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: onPrimaryColor,
    displayColor: onPrimaryColor,
  ),
  scaffoldBackgroundColor: primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: onPrimaryColor,
  ),
  iconTheme: const IconThemeData(color: onPrimaryColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
    selectedItemColor: secondaryColor,
    unselectedItemColor: onTertiaryColor,
    type: BottomNavigationBarType.fixed,
  ),
);
