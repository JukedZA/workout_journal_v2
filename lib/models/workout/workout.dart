import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:workout_journal_v2/models/workout/exercise.dart';

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
  const Workout({
    required this.id,
    required this.title,
    required this.date,
    required this.img,
    required this.exercises,
  });

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
