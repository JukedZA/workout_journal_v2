import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class MySwitch extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  const MySwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: AppColors.secondary,
      activeTrackColor: AppColors.redAccent,
      inactiveTrackColor: AppColors.tertiary,
      inactiveThumbColor: AppColors.secondaryText,
      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
      value: value,
      onChanged: onChanged,
    );
  }
}
