import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';

part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String img;
  @HiveField(4)
  final List<Exercise> exercises;
  @HiveField(5)
  final bool isTemplate;

  const Workout({
    required this.id,
    required this.title,
    required this.date,
    this.img = 'assets/images/workout-journal.png',
    required this.exercises,
    this.isTemplate = false,
  });

  Workout copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? img,
    List<Exercise>? exercises,
    bool? isTemplate,
  }) {
    List<Exercise> newExercises = [];

    for (final exercise in exercises ?? this.exercises) {
      String newId = const Uuid().v4();

      Exercise newExercise = exercise.copyWith(
        id: newId,
      );

      newExercises.add(newExercise); // Append the new exercise to the list
    }

    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      img: img ?? this.img,
      exercises: newExercises,
      isTemplate: isTemplate ?? this.isTemplate,
    );
  }

  String get formattedDate {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }
}
