import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_filter_provider.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/body_items/workout_container/workout_item.dart';

class DashboardContainer extends ConsumerWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String filter = ref.watch(workoutFilterProvider);
    List<Workout> workouts = ref.watch(workoutsProvider);
    List<Workout> filteredWorkouts = [];

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

    if (filteredWorkouts.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.redAccent.withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.zoom_out_rounded,
                  size: 50,
                  color: AppColors.redAccent,
                ),
              ),
              const SizedBox(height: 25),
              const TextHeebo(
                text: 'No Workouts Found',
                size: 18,
                weight: Weights.medium,
                color: AppColors.secondaryText,
              ),
            ],
          ),
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
            itemBuilder: (context, index) => WorkoutItem(
              workout: filteredWorkouts[index],
            ),
          ),
        ),
      );
    }
  }
}
