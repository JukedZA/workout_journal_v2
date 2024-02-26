import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/Templates/create_template_body.dart';

class CreateTemplate extends StatelessWidget {
  const CreateTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'Create Template',
          size: 24,
        ),
      ),
      body: const CreateTemplateForm(),
    );
  }
}
