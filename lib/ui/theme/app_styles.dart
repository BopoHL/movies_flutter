import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_flutter/ui/theme/app_colors.dart';

abstract class AppTextStyle {
  static TextStyle title = GoogleFonts.poppins(fontSize: 20, color: AppColors.white, fontWeight: FontWeight.w700);
  static TextStyle rating = GoogleFonts.poppins(fontSize: 22, color: AppColors.white, fontWeight: FontWeight.w500);
  static TextStyle description = GoogleFonts.poppins(fontSize: 13, color: AppColors.greyText, fontWeight: FontWeight.w400);
}