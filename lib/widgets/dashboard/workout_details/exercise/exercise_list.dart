import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/exercise.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
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
          itemBuilder: (context, index) => Slidable(
            key: ValueKey(exercises[index]),
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(workoutsProvider.notifier)
                            .removeExercise(workout, exercises[index]);

                        Methods.showToastMessage(
                            context,
                            AppColors.redAccent,
                            Icons.check_rounded,
                            'Exercise Deleted Successfully');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            TextHeeboReg(text: 'Delete', size: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: ExerciseItem(
              exercise: exercises[index],
            ),
          ),
        ),
      ),
    );
  }
}
