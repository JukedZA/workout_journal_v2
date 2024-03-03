import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/calorie_calculator.dart/calorie_results_body.dart';

class CalorieCalculatorResults extends StatelessWidget {
  final double result;
  const CalorieCalculatorResults({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'Results',
          size: 24,
        ),
      ),
      body: CalorieResultsBody(
        calories: result,
      ),
    );
  }
}
