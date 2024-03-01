import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/models/workout/workout_json_converter.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/custom_popup_body.dart';
import 'package:workout_journal_v2/widgets/custom/no_items_found.dart';
import 'package:workout_journal_v2/widgets/custom/page_animator.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/exercise/exercise_list.dart';

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
          ExerciseList(workout: workout),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: TextHeeboBold(text: workout.title, size: 22),
        actions: [
          PopupMenuButton(
            surfaceTintColor: Colors.transparent,
            color: AppColors.secondary,
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    context.goNamed(Routes.createExercise, extra: workout);
                  },
                  child: const CustomPopupBody(
                    title: 'Create Exercise',
                    icon: Icons.add_circle_rounded,
                    iconSize: 22,
                  ),
                ),
                PopupMenuItem(
                  onTap: () async {
                    final WorkoutJsonConverter converter =
                        WorkoutJsonConverter(workout: workout);

                    await converter.exportWorkout();
                  },
                  child: const CustomPopupBody(
                    title: 'Share',
                    icon: Icons.share_rounded,
                    iconSize: 20,
                  ),
                ),
              ];
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: PageContainer(child: content),
    );
  }
}
