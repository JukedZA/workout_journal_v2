import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class ExerciseItemForm extends StatelessWidget {
  final void Function() onTap;
  final void Function(String? value) onChanged;
  final void Function() onEditingComplete;
  final TextEditingController controller;
  const ExerciseItemForm({
    Key? key,
    required this.onTap,
    required this.onChanged,
    required this.onEditingComplete,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      color: AppColors.stickyNote,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.secondary,
        validator: (value) {
          return null;
        },
        onEditingComplete: onEditingComplete,
        style: GoogleFonts.heebo(
          color: AppColors.secondary,
          fontSize: 11,
          fontWeight: Weights.medium,
        ),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.heebo(
            color: AppColors.secondary,
            fontSize: 11,
            fontWeight: Weights.medium,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: '',
          prefixIcon: const Icon(
            Icons.sticky_note_2_outlined,
            size: 16,
            color: AppColors.secondary,
          ),
          suffixIcon: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: onTap,
            child: const SizedBox(
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.secondary,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(4),
          filled: true,
          fillColor: Colors.transparent,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
