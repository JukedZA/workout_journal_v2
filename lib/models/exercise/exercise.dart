import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/set/set.dart';

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
  @HiveField(6)
  final String trackerID;

  const Exercise({
    required this.id,
    required this.title,
    this.workoutType = 'Type not found',
    this.notes = '',
    this.hasNotes = false,
    required this.sets,
    this.trackerID = '',
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
    String? trackerID,
  }) {
    List<SetModel> newSets = [];

    for (final s in sets ?? this.sets) {
      String newId = const Uuid().v4();

      SetModel newSet = s.copyWith(id: newId);

      newSets.add(newSet);
    }

    return Exercise(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      hasNotes: hasNotes ?? this.hasNotes,
      workoutType: workoutType ?? this.workoutType,
      sets: newSets,
      trackerID: trackerID ?? this.trackerID,
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? 'ID not found',
      title: json['title'] ?? 'Title not found',
      notes: json['notes'] ?? '',
      hasNotes: json['hasNotes'] ?? false,
      workoutType: json['type'] ?? 'Type not found',
      sets: List<SetModel>.from(
          json['sets'].map((setJson) => SetModel.fromJson(setJson))),
      trackerID: '',
    );
  }
}
