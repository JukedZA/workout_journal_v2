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
}
