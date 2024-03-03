import 'package:flutter/material.dart';
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
          text: 'Caloric Range Calculator',
          size: 24,
        ),
      ),
      body: const CalorieCalculatorBody(),
    );
  }
}
