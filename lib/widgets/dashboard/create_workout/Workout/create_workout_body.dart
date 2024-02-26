import 'package:flutter/material.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/create_workout_form.dart';

class CreateWorkoutBody extends StatelessWidget {
  const CreateWorkoutBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: [
          CreateWorkoutForm(),
        ],
      ),
    );
  }
}
