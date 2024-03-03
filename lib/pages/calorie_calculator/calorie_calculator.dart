import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/calorie_calculator.dart/calorie_calculator_body.dart';

class CalorieCalculator extends StatelessWidget {
  const CalorieCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'Calorie Calculator',
          size: 24,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: const TextHeeboBold(text: 'Please Note', size: 16),
                  content: const TextHeeboMedium(
                    text:
                        """This calorie calculator uses the Mifflin St. Jeor equation and may not be 100% accurate.

Ages outside of the range may be less accurate.""",
                    size: 12,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.info_rounded,
            ),
          ),
        ],
      ),
      body: const CalorieCalculatorBody(),
    );
  }
}
