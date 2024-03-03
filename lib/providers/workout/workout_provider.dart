import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';
import 'package:workout_journal_v2/models/set/set.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';

class CurrentWorkoutNotifier extends Notifier<Workout?> {
  @override
  Workout? build() {
    return null;
  }

  void setWorkout(Workout workout) {
    state = workout;
  }

  void saveNotes(Exercise exercise, String notes) {
    if (state == null) return;

    // Link to the workout object
    final Workout workout = state!;

    int exerciseIndex =
        workout.exercises.indexWhere((e) => e.id == exercise.id);

    if (exerciseIndex != -1) {
      // Create a new Exercise instance with the updated notes
      Exercise updatedExercise = Exercise(
        title: exercise.title,
        id: exercise.id,
        workoutType: exercise.workoutType,
        hasNotes: exercise.hasNotes,
        notes: notes,
        sets: exercise.sets,
      );

      workout.exercises[exerciseIndex] = updatedExercise;
    }
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

  void clearWorkouts() {
    if (state.isNotEmpty) {
      final newList =
          state.where((workout) => workout.isTemplate == true).toList();

      Constants.workoutBox.put('workouts', newList);

      state = newList;
    }
  }

  void reorderExercises(Workout workout, List<Exercise> newExercises) {
    if (state.isNotEmpty) {
      final Workout newWorkout = Workout(
        id: workout.id,
        title: workout.title,
        date: workout.date,
        img: workout.img,
        exercises: newExercises,
        isTemplate: workout.isTemplate,
      );

      final int index = state.indexWhere((w) => w.id == workout.id);

      if (index != -1) {
        List<Workout> newState = List.from(state);

        newState[index] = newWorkout;

        state = newState;
      }
    }
  }

  void clearTemplates() {
    if (state.isNotEmpty) {
      final newList =
          state.where((workout) => workout.isTemplate == false).toList();

      Constants.workoutBox.put('workouts', newList);

      state = newList;
    }
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

  void replaceExercise(Exercise newExercise) {
    final List<Workout> tempList = List.from(state);
    final Workout? workout = ref.read(currentWorkoutProvider);

    if (tempList.isEmpty || workout == null) return;

    // Find the index of the workout with a matching id
    int workoutIndex = tempList.indexWhere((w) => w.id == workout.id);

    int exerciseIndex =
        workout.exercises.indexWhere((e) => e.id == newExercise.id);

    if (workoutIndex != -1) {
      // Create a copy of the workout
      Workout updatedWorkout = workout.copyWith(
        exercises:
            List.from(workout.exercises), // Create a copy of the exercises list
      );

      if (exerciseIndex != -1) {
        // Create a new Exercise instance with the updated notes
        Exercise updatedExercise = Exercise(
          title: newExercise.title,
          id: newExercise.id,
          workoutType: newExercise.workoutType,
          hasNotes: newExercise.hasNotes,
          notes: newExercise.notes,
          sets: newExercise.sets,
        );

        // Replace the old exercise with the updated one
        updatedWorkout.exercises[exerciseIndex] = updatedExercise;
      }

      ref.read(currentWorkoutProvider.notifier).setWorkout(updatedWorkout);

      tempList[workoutIndex] = updatedWorkout;

      Constants.workoutBox.put('workouts', tempList);
      state = tempList;
    }
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
        isTemplate: workout.isTemplate,
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
    final List<Workout> tempList =
        List.from(state); // Create a new list from the current state

    // Create a copy of the workout with the new exercises
    final Workout newWorkout = Workout(
      id: workout.id,
      title: workout.title,
      date: workout.date,
      img: workout.img,
      exercises: [...workout.exercises, exercise],
      isTemplate: workout.isTemplate,
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
