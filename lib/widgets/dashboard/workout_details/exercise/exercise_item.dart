import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/exercise.dart';
import 'package:workout_journal_v2/models/workout/set.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/set/set_list.dart';

class ExerciseItem extends ConsumerStatefulWidget {
  final Exercise exercise;
  const ExerciseItem({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  ConsumerState<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends ConsumerState<ExerciseItem> {
  final _formKey = GlobalKey<FormState>();

  void _createSet(SetModel setItem) {
    final List<Workout> allWorkouts = ref.watch(workoutsProvider);

    ref.read(currentWorkoutProvider.notifier).saveSet(
          setItem,
          widget.exercise,
        );

    Constants.workoutBox.put('workouts', allWorkouts);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: AppColors.tertiary,
              child: TextHeeboBold(text: widget.exercise.title, size: 16),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
              child: SetList(
                sets: widget.exercise.sets,
                saveSet: _createSet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
