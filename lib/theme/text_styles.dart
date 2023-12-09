import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class TextHeebo extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  const TextHeebo({
    Key? key,
    required this.text,
    required this.size,
    required this.color,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.heebo(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}

class TextHeeboReg extends StatelessWidget {
  final String text;
  final double size;
  const TextHeeboReg({
    Key? key,
    required this.text,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.heebo(
        color: AppColors.primaryText,
        fontSize: size,
        fontWeight: Weights.reg,
      ),
    );
  }
}

class TextHeeboMedium extends StatelessWidget {
  final String text;
  final double size;
  const TextHeeboMedium({
    Key? key,
    required this.text,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.heebo(
        color: AppColors.primaryText,
        fontSize: size,
        fontWeight: Weights.medium,
      ),
    );
  }
}

class TextHeeboBold extends StatelessWidget {
  final String text;
  final double size;
  const TextHeeboBold({
    Key? key,
    required this.text,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.heebo(
        color: AppColors.primaryText,
        fontSize: size,
        fontWeight: Weights.bold,
      ),
    );
  }
}
