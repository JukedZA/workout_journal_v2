import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/exercise/exercise_list.dart';

class WorkoutDetails extends ConsumerWidget {
  const WorkoutDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Workout workout = ref.watch(currentWorkoutProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: TextHeeboBold(text: workout.title, size: 22),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(Routes.createExercise, extra: workout);
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          ExerciseList(workout: workout),
        ],
      ),
    );
  }
}
