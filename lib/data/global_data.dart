import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';

class Constants {
  // USER INFO
  static late String name;

  // WORKOUT STORAGE
  static late Box workoutBox;
  static List<Workout> workouts = [];

  // METHODS
  static void setList(List<Workout> list) {
    workouts = list;
  }

  static void setName(String n) {
    name = Methods.formatName(n);
  }
}

class Methods {
  static String formatName(String name) {
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}

class Weights {
  static const reg = FontWeight.w300;
  static const medium = FontWeight.w400;
  static const bold = FontWeight.w700;
}
