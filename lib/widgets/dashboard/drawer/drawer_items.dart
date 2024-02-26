import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/button_styles.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class DrawerItems extends ConsumerWidget {
  const DrawerItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
              ),
              child: Image.asset(
                'assets/images/workout-journal.png',
                width: 150,
              ),
            ),
            const SizedBox(height: 25),
            DrawerItem(
              title: 'Profile',
              icon: Icons.person_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {
                context.goNamed(Routes.profile);

                context.pop();
              },
              backgroundColor: AppColors.secondary,
            ),
            const SizedBox(height: 8),
            DrawerItem(
              title: 'Templates',
              icon: Icons.file_copy_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {
                context.goNamed(Routes.workoutTemplates);

                context.pop();
              },
              backgroundColor: AppColors.secondary,
            ),
          ],
        ),
        Column(
          children: [
            DrawerItem(
              title: 'Clear Workouts',
              icon: Icons.delete_forever_rounded,
              trailingIcon: null,
              onTap: () async {
                bool clear = await confirmRemoval(context);

                if (clear) {
                  ref.read(workoutsProvider.notifier).setList(<Workout>[]);
                  if (context.mounted) {
                    context.pop();
                  }
                } else {
                  if (context.mounted) {
                    context.pop();
                  }
                }
              },
              backgroundColor: AppColors.redAccent,
            ),
            const SizedBox(height: 25),
          ],
        )
      ],
    );
  }

  Future<bool> confirmRemoval(BuildContext context) async {
    bool? clearItems = await showDialog(
      barrierColor: AppColors.secondary.withOpacity(0.7),
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.primary,
        title: const TextHeeboMedium(
          text: 'Clear ALL Workouts',
          size: 20,
        ),
        content: const TextHeeboReg(
          text: 'Are you sure?',
          size: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        actionsPadding: const EdgeInsets.all(16),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            style: const RoundedBorderStyle(color: AppColors.secondary)
                .buildButtonStyle(),
            onPressed: () {
              context.pop(false);
            },
            child: const TextHeebo(
              text: 'No',
              size: 12,
              weight: Weights.reg,
              color: AppColors.primaryText,
            ),
          ),
          TextButton(
            style: const RoundedButtonStyle(color: AppColors.redAccent)
                .buildButtonStyle(),
            onPressed: () {
              context.pop(true);
            },
            child: const TextHeebo(
              text: 'Yes',
              size: 12,
              weight: Weights.medium,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );

    return clearItems ?? false;
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final IconData? trailingIcon;
  final void Function() onTap;
  final Color backgroundColor;
  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.trailingIcon,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.white,
                  size: 22,
                ),
                const SizedBox(width: 8),
                TextHeeboMedium(text: title, size: 16),
              ],
            ),
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: AppColors.white,
                size: 22,
              )
          ],
        ),
      ),
    );
  }
}
