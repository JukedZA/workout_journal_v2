import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/widgets/custom/animations/page_animator.dart';
import 'package:workout_journal_v2/widgets/custom/no_items_found.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/exercise/exercise_list.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/nav/workout_details_nav.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/workout_details_timer.dart';

class WorkoutDetails extends ConsumerWidget {
  const WorkoutDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Workout workout = ref.watch(currentWorkoutProvider)!;

    Widget content;

    if (workout.exercises.isEmpty) {
      content = const NoItemsFound(
        title: 'No Exercises Found',
        subtitle: 'Click the plus to create one',
      );
    } else {
      content = Column(
        children: [
          if (!workout.isTemplate) WorkoutDetailsTimer(workout: workout),
          ExerciseList(workout: workout),
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: WorkoutDetailsNav(workout: workout),
      ),
      body: PageContainer(child: content),
    );
  }
}
