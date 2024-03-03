import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class MyFormField extends StatelessWidget {
  final String hintText;
  final bool isNumbers;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final void Function(String? newValue) onSaved;
  const MyFormField({
    Key? key,
    required this.hintText,
    required this.isNumbers,
    required this.suffixIcon,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.secondaryText,
      validator: validator,
      keyboardType: isNumbers ? TextInputType.number : null,
      inputFormatters: isNumbers
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
          : null,
      style: GoogleFonts.heebo(
        color: AppColors.primaryText,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintStyle: GoogleFonts.heebo(
          color: AppColors.secondaryText,
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(18),
        filled: true,
        fillColor: AppColors.secondary,
      ),
      onSaved: onSaved,
    );
  }
}
