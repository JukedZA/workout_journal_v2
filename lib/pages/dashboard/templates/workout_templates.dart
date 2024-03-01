import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/models/workout/workout_json_converter.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
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
          IconButton(
            onPressed: () async {
              final Workout? workout =
                  await WorkoutJsonConverter.importFromFile();

              if (workout != null) {
                ref.read(workoutsProvider.notifier).addItem(workout);
              }
            },
            icon: const Icon(Icons.arrow_circle_up_rounded),
          ),
          IconButton(
            onPressed: () {
              context.goNamed(Routes.createTemplate);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: const TemplateBody(),
    );
  }
}
