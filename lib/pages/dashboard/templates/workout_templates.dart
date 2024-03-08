import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/models/workout/workout_json_converter.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/popup_menu/custom_popup_body.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/Template/template_body.dart';

class WorkoutTemplates extends ConsumerWidget {
  const WorkoutTemplates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'Your Templates',
          size: 24,
        ),
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
                    context.goNamed(Routes.createTemplate);
                  },
                  child: const CustomPopupBody(
                    title: 'Create Template',
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
                    final Workout? workout =
                        await WorkoutJsonConverter.importFromFile();

                    if (workout != null) {
                      ref.read(workoutsProvider.notifier).addItem(workout);
                    }
                  },
                  child: const CustomPopupBody(
                    title: 'Import Workout',
                    icon: Icons.file_open_rounded,
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
      body: const TemplateBody(),
    );
  }
}
