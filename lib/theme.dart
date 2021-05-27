import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryColors {
  static final purple = Color(0xFF5117AC);
  static final green = Color(0xFF20D0C4);
  static final white = Color(0xFFFFFFFF);
  static final grey = Color(0xfff1f1f1);
  static final darkgrey = Color(0xff878488);
  static final blue = Color(0xff0093ff);
}

final lightTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: DeliveryColors.darkgrey,
    displayColor: DeliveryColors.white,
  ),
);

final deliveryGradients = [
  DeliveryColors.darkgrey,
  DeliveryColors.grey,
];
