import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_filter_provider.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/no_items_found.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/body_items/workout_container/workout_item.dart';

class DashboardContainer extends ConsumerWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String filter = ref.watch(workoutFilterProvider);
    final List<Workout> allWorkouts = ref.watch(workoutsProvider);
    List<Workout> filteredWorkouts = [];
    List<Workout> workouts = [];

    if (allWorkouts.isNotEmpty) {
      workouts =
          allWorkouts.where((workout) => workout.isTemplate == false).toList();

      if (workouts.isNotEmpty) {
        filteredWorkouts = workouts
            .where(
              (workout) => workout.title
                  .trim()
                  .toLowerCase()
                  .contains(filter.trim().toLowerCase()),
            )
            .toList();
      }
    }

    if (filteredWorkouts.isEmpty) {
      return const Expanded(
        child: NoItemsFound(
          title: 'No Workouts Found',
          subtitle: 'Click the plus to create one',
        ),
      );
    } else {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: filteredWorkouts.length,
            itemBuilder: (context, index) => Slidable(
              key: ValueKey(workouts[index]),
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 8),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(workoutsProvider.notifier)
                              .removeWorkout(workouts[index]);
                          showConfirmationMessage(context);
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
                                size: 25,
                                color: Colors.white,
                              ),
                              TextHeeboReg(text: 'Delete', size: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              child: WorkoutItem(
                workout: filteredWorkouts[index],
              ),
            ),
          ),
        ),
      );
    }
  }

  void showConfirmationMessage(BuildContext context) {
    Methods.showToastMessage(context, AppColors.redAccent, Icons.check_rounded,
        'Workout Deleted Successfully');
  }
}
