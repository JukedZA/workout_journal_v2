import 'package:hive_flutter/hive_flutter.dart';

part 'set.g.dart';

@HiveType(typeId: 2)
class SetModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double? weight;
  @HiveField(2)
  final double? reps;
  @HiveField(3)
  final bool isWarmup;
  const SetModel({
    required this.id,
    required this.weight,
    required this.reps,
    required this.isWarmup,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'reps': reps,
      'isWarmup': isWarmup,
    };
  }

  SetModel copyWith({
    String? id,
    double? weight,
    double? reps,
    bool? isWarmup,
  }) {
    return SetModel(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      isWarmup: isWarmup ?? this.isWarmup,
    );
  }

  factory SetModel.fromJson(Map<String, dynamic> json) {
    return SetModel(
      id: json['id'] ?? 'ID not found',
      weight: json['weight'] ?? 0,
      reps: json['reps'] ?? 0,
      isWarmup:
          json['isWarmup'] ?? false, // Set default value if isWarmup is null
    );
  }
}
