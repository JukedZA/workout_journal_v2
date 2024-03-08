import 'package:flutter/material.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class CustomPopupBody extends StatelessWidget {
  final String title;
  final IconData icon;
  final double iconSize;
  const CustomPopupBody({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextHeebo(
          text: title,
          size: 14,
          color: AppColors.secondaryText,
          weight: Weights.medium,
        ),
        const Spacer(),
        Icon(
          icon,
          color: AppColors.redAccent,
          size: iconSize,
        ),
      ],
    );
  }
}
