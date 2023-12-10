import 'package:flutter/material.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class NoItemsFound extends StatelessWidget {
  final String title;
  final String subtitle;
  const NoItemsFound({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.redAccent.withOpacity(0.2),
            ),
            child: const Icon(
              Icons.zoom_out_rounded,
              size: 50,
              color: AppColors.redAccent,
            ),
          ),
          const SizedBox(height: 25),
          TextHeebo(
            text: title,
            size: 18,
            weight: Weights.medium,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: 4),
          TextHeebo(
            text: subtitle,
            size: 12,
            weight: Weights.reg,
            color: AppColors.tertiary,
          ),
        ],
      ),
    );
  }
}
