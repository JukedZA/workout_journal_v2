import 'package:flutter/material.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class CalorieResultsBody extends StatelessWidget {
  final double calories;
  const CalorieResultsBody({
    Key? key,
    required this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            calorieContainer(
              calories,
              'Maintenance Calories',
              24,
              AppColors.redAccent,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextHeebo(
                        text: 'Lose Weight',
                        size: 14,
                        color: AppColors.secondaryText,
                        weight: Weights.bold,
                      ),
                      const SizedBox(height: 4),
                      calorieItem(
                        calories - 250,
                        AppColors.blueAccent,
                        'Mild',
                      ),
                      const SizedBox(height: 4),
                      calorieItem(
                        calories - 500,
                        AppColors.blueAccent,
                        'Average',
                      ),
                      const SizedBox(height: 4),
                      calorieItem(
                        calories - 1000,
                        AppColors.blueAccent,
                        'Extreme',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextHeebo(
                        text: 'Gain Weight',
                        size: 14,
                        color: AppColors.secondaryText,
                        weight: Weights.bold,
                      ),
                      const SizedBox(height: 4),
                      calorieItem(
                        calories + 250,
                        AppColors.greenAccent,
                        'Mild',
                      ),
                      const SizedBox(height: 4),
                      calorieItem(
                        calories + 500,
                        AppColors.greenAccent,
                        'Average',
                      ),
                      const SizedBox(height: 4),
                      calorieItem(
                        calories + 1000,
                        AppColors.greenAccent,
                        'Extreme',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget calorieItem(double calories, Color color, String title) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: TextHeeboMedium(text: title, size: 12),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextHeebo(
                    text: calories.truncate().toString(),
                    size: 18,
                    color: AppColors.white,
                    weight: Weights.bold,
                  ),
                  const TextHeeboReg(
                    text: 'kcal/day',
                    size: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget calorieContainer(
      double calories, String title, double size, Color color) {
    return Column(
      children: [
        TextHeebo(
          text: title,
          size: 14,
          color: AppColors.secondaryText,
          weight: Weights.bold,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextHeeboBold(
                      text: calories.truncate().toString(),
                      size: size,
                    ),
                    Baseline(
                      baseline: -size / 2.75,
                      baselineType: TextBaseline.alphabetic,
                      child: const TextHeeboReg(
                        text: ' kcal/day',
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
