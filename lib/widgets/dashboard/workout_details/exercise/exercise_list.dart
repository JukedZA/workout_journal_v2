import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/models/workout/exercise.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/exercise/exercise_item.dart';

class ExerciseList extends ConsumerWidget {
  final Workout workout;
  const ExerciseList({
    Key? key,
    required this.workout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Exercise> exercises = workout.exercises;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) => ExerciseItem(
            exercise: exercises[index],
          ),
        ),
      ),
    );
  }
}
