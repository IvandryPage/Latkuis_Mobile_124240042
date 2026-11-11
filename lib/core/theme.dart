import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF4EAD5);
const Color secondaryColor = Color(0xFF1E3B2F);
const Color tertiaryColor = Color(0xFFFF3EA5);
const Color onPrimaryColor = Color(0xFF1E3B2F);
const Color onSecondaryColor = Color(0xFFF4EAD5);
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
    selectedItemColor: tertiaryColor,
    unselectedItemColor: secondaryColor,
    type: BottomNavigationBarType.fixed,
  ),
);
