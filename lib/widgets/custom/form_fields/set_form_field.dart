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
      height: 35,
      width: 50,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.white,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        onSaved: onSaved,
        onChanged: onChanged,
        initialValue: initialValue,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryText),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          contentPadding: EdgeInsets.all(0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          filled: false,
          hintStyle: TextStyle(color: AppColors.primaryText),
          hintText: '',
        ),
      ),
    );
  }
}
