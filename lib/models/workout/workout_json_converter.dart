import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';

class WorkoutJsonConverter {
  final Workout workout;

  const WorkoutJsonConverter({
    required this.workout,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> exercisesJson =
        workout.exercises.map((exercise) => exercise.toJson()).toList();

    return {
      'id': workout.id,
      'title': workout.title,
      'date': workout.date.toIso8601String(),
      'img': workout.img,
      'exercises': exercisesJson,
      'isTemplate': workout.isTemplate,
    };
  }

  Future<void> exportWorkout() async {
    // Convert workout to JSON
    String workoutJson = jsonEncode(toJson());

    // Get the directory for saving temporary files
    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/workout.json';

    // Write the JSON to a file
    File file = File(filePath);
    await file.writeAsString(workoutJson);

    // Share the file via other apps
    Share.shareFiles([filePath], text: 'Check out my workout!');
  }

  static Future<Workout?> importFromFile() async {
    // Allow the user to pick a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.first.path!);
      String contents = await file.readAsString();
      Map<String, dynamic> json = jsonDecode(contents);
      List<dynamic> exercisesJson = json['exercises'];
      List<Exercise> exercises = exercisesJson
          .map((exerciseJson) => Exercise.fromJson(exerciseJson))
          .toList();
      return Workout(
        id: const Uuid().v4(),
        title: json['title'] ?? 'Title not found',
        date: DateTime.now(),
        img: json['img'] ?? 'assets/images/workout-journal.png',
        exercises: exercises,
        isTemplate: true,
      );
    } else {
      // User canceled file picking
      return null;
    }
  }
}
