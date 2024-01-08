import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/exercise.dart';
import 'package:workout_journal_v2/models/workout/set.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';

class CurrentWorkoutNotifier extends Notifier<Workout?> {
  @override
  Workout? build() {
    return null;
  }

  void setWorkout(Workout workout) {
    state = workout;
  }

  void saveSet(SetModel setItem, Exercise exercise) {
    if (state == null) return;

    if (exercise.sets.isNotEmpty) {
      final int index =
          exercise.sets.indexWhere((item) => item.id == setItem.id);

      if (index != -1) {
        // If the item with the specified ID is found
        exercise.sets.removeAt(index);
        exercise.sets.insert(index, setItem);
      } else {
        // Handle the case when the item with the specified ID is not found
        debugPrint('SetModel with ID ${setItem.id} not found in the exercise.');
      }
    }
  }
}

final currentWorkoutProvider =
    NotifierProvider<CurrentWorkoutNotifier, Workout?>(
  () => CurrentWorkoutNotifier(),
);

class WorkoutsNotifier extends Notifier<List<Workout>> {
  @override
  List<Workout> build() {
    return Constants.workouts;
  }

  void setList(List<Workout> list) {
    Constants.workoutBox.put('workouts', list);

    state = list;
  }

  void addItem(Workout item) {
    final List<Workout> list = [item, ...state];

    Constants.workoutBox.put('workouts', list);

    state = list;
  }

  void removeExercise(Workout workout, Exercise exercise) {
    final List<Workout> tempList = List.from(state);

    if (tempList.isEmpty) return;

    // Find the index of the workout with a matching id
    int index = tempList.indexWhere((w) => w.id == workout.id);

    if (index != -1) {
      // Create a copy of the workout with the exercise removed
      final Workout updatedWorkout = Workout(
        id: workout.id,
        title: workout.title,
        date: workout.date,
        img: workout.img,
        exercises: List.from(workout.exercises)..remove(exercise),
      );

      // Replace the old workout with the updated one
      tempList[index] = updatedWorkout;

      // Update the current workout
      ref.read(currentWorkoutProvider.notifier).setWorkout(updatedWorkout);

      // Update the box and state
      Constants.workoutBox.put('workouts', tempList);
      state = tempList;
    }
  }

  void addExercise(Workout workout, Exercise exercise) {
    print(state);
    final List<Workout> tempList =
        List.from(state); // Create a new list from the current state

    // Create a copy of the workout with the new exercises
    final Workout newWorkout = Workout(
      id: workout.id,
      title: workout.title,
      date: workout.date,
      img: workout.img,
      exercises: [...workout.exercises, exercise],
    );

    // Find the index of the old workout
    int index = tempList.indexOf(workout);

    // Replace the old workout at the index
    tempList[index] = newWorkout;

    // Update the current workout
    ref.read(currentWorkoutProvider.notifier).setWorkout(newWorkout);

    // Update the box and state
    Constants.workoutBox.put('workouts', tempList);
    state = tempList;
  }

  void removeWorkout(Workout workout) {
    final List<Workout> tempList = List.from(state);

    if (tempList.isEmpty) return;

    // Find the index of the workout with a matching id
    int index = tempList.indexWhere((w) => w.id == workout.id);

    if (index != -1) {
      // Remove the workout if found
      tempList.removeAt(index);

      // Update the box and state
      Constants.workoutBox.put('workouts', tempList);
      state = tempList;
    }
  }
}

final workoutsProvider = NotifierProvider<WorkoutsNotifier, List<Workout>>(
  () => WorkoutsNotifier(),
);
