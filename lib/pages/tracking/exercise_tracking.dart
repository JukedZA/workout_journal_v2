import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_tracking/workout_tracker_body.dart';

class ExerciseTracking extends StatelessWidget {
  const ExerciseTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHeeboBold(text: 'Workout Tracking', size: 22),
      ),
      body: const TrackerBody(),
    );
  }
}
