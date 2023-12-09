import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class SetFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String? newValue) onSaved;
  final void Function(String? newValue) onChanged;
  const SetFormField({
    Key? key,
    required this.controller,
    required this.initialValue,
    required this.onChanged,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 50,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.white,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onSaved: onSaved,
        onChanged: onChanged,
        initialValue: initialValue,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryText),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.all(0),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: AppColors.secondary,
          hintStyle: const TextStyle(color: AppColors.primaryText),
          hintText: '',
        ),
      ),
    );
  }
}
