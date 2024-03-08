import 'package:hive_flutter/hive_flutter.dart';

part 'tracking_model.g.dart';

@HiveType(typeId: 3)
class Tracker {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;

  const Tracker({
    required this.id,
    required this.title,
  });
}
