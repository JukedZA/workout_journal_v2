import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/Templates/template_body.dart';

class WorkoutTemplates extends StatelessWidget {
  const WorkoutTemplates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'Your Templates',
          size: 24,
        ),
        actions: [
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
