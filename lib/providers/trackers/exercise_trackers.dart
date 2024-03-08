import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/tracking/tracking_model.dart';

class CurrentTrackersNotifier extends Notifier<List<Tracker>> {
  @override
  List<Tracker> build() {
    return [];
  }

  void setState(List<Tracker> trackers) {
    state = trackers;
  }

  void addTracker(Tracker tracker) {
    state = [...state, tracker];
  }

  void removeTracker(Tracker tracker) {
    List<Tracker> tempList = List.from(state);

    if (state.isNotEmpty) {
      tempList.removeWhere((t) => t.id == tracker.id);

      state = tempList;
    }
  }
}

class ExerciseTrackerNotifier extends Notifier<List<Tracker>> {
  @override
  List<Tracker> build() {
    return Constants.trackers;
  }

  void addTracker(Tracker tracker) {
    state = [...state, tracker];

    saveTrackers();
  }

  void removeTracker(Tracker tracker) {
    if (state.isNotEmpty) {
      state = state.where((t) => t.id != tracker.id).toList();
      saveTrackers();
    }
  }

  void saveTrackers() {
    try {
      Constants.workoutBox.put(BoxNames.trackers, state);
    } catch (e) {
      // Handle exceptions, e.g., log the error or show a message to the user
      debugPrint('Error saving trackers: $e');
    }
  }
}

final trackersProvider =
    NotifierProvider<ExerciseTrackerNotifier, List<Tracker>>(
  () => ExerciseTrackerNotifier(),
);

final currentTrackersProvider =
    NotifierProvider<CurrentTrackersNotifier, List<Tracker>>(
  () => CurrentTrackersNotifier(),
);
