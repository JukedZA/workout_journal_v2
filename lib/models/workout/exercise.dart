import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/workout/set.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String workoutType;
  @HiveField(3)
  final String notes;
  @HiveField(4)
  final bool hasNotes;
  @HiveField(5)
  final List<SetModel> sets;
  const Exercise({
    required this.id,
    required this.title,
    required this.workoutType,
    required this.notes,
    required this.hasNotes,
    required this.sets,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'hasNotes': hasNotes,
      'type': workoutType,
      'sets': sets.map((s) => s.toJson()).toList(),
    };
  }

  Exercise copyWith({
    String? id,
    String? title,
    String? notes,
    bool? hasNotes,
    String? workoutType,
    List<SetModel>? sets,
  }) {
    List<SetModel> newSets = sets ?? this.sets;

    for (int i = 0; i < newSets.length; i++) {
      String newId = const Uuid().v4();
      newSets[i] = newSets[i].copyWith(id: newId);
    }

    return Exercise(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      hasNotes: hasNotes ?? this.hasNotes,
      workoutType: workoutType ?? this.workoutType,
      sets: newSets,
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      title: json['title'],
      notes: json['notes'],
      hasNotes: json['hasNotes'],
      workoutType: json['type'],
      sets: List<SetModel>.from(
          json['sets'].map((setJson) => SetModel.fromJson(setJson))),
    );
  }
}
