import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutFilterNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void setFilter(String f) {
    state = f;
  }
}

final workoutFilterProvider = NotifierProvider<WorkoutFilterNotifier, String>(
  () => WorkoutFilterNotifier(),
);
