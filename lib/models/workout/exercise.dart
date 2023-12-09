import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout_journal_v2/models/workout/set.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<SetModel> sets;
  const Exercise({
    required this.id,
    required this.title,
    required this.sets,
  });
}
