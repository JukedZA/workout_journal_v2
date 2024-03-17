import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/models/workout/workout_json_converter.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/popup_menu/custom_popup_body.dart';

class WorkoutDetailsNav extends StatelessWidget {
  final Workout workout;
  const WorkoutDetailsNav({
    Key? key,
    required this.workout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                height: 5,
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: AppColors.tertiary,
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
    );
  }
}

class IconItem extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  const IconItem({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.redAccent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.primaryText,
        ),
      ),
    );
  }
}
