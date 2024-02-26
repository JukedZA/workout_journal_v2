import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/Workout/create_workout_body.dart';

class CreateWorkout extends StatelessWidget {
  const CreateWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'New Workout',
          size: 24,
        ),
      ),
      body: const CreateWorkoutBody(),
    );
  }
}
