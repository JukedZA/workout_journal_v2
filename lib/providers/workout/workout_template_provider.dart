// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workout_journal_v2/data/global_data.dart';
// import 'package:workout_journal_v2/models/workout/workout.dart';

// class WorkoutTemplatesNotifier extends Notifier<List<Workout>> {
//   @override
//   List<Workout> build() {
//     return Constants.templates;
//   }

//   void addTemplate(Workout workout) {
//     state = [...state, workout];
//   }
// }

// final templatesProvider =
//     NotifierProvider<WorkoutTemplatesNotifier, List<Workout>>(
//   () => WorkoutTemplatesNotifier(),
// );
