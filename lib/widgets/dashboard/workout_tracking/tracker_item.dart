import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';
import 'package:workout_journal_v2/models/tracking/tracking_model.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/drop_down.dart';
import 'package:workout_journal_v2/widgets/custom/graph/graph.dart';

class TrackerItem extends ConsumerStatefulWidget {
  final Tracker tracker;
  const TrackerItem({
    Key? key,
    required this.tracker,
  }) : super(key: key);

  @override
  ConsumerState<TrackerItem> createState() => _TrackerItemState();
}

class _TrackerItemState extends ConsumerState<TrackerItem> {
  final List<String> _dropdownValues = ['Top Set', 'All Sets'];

  String _dropdown = 'Top Set';

  double _oneRepMax = 0;

  final List<double> _repList = [];
  final List<double> _weightList = [];

  final List<double> _values = [];

  double _estimateOneRepMax(double weightLifted, double repetitions) {
    return weightLifted / (1.0278 - 0.0278 * repetitions);
  }

  void _calculateTopSet(List<Exercise> exercises) {
    _values.clear();
    _repList.clear();
    _weightList.clear();

    for (final exercise in exercises) {
      double reps = 0;
      double weight = 0;
      _oneRepMax = 0;

      for (final s in exercise.sets) {
        if (s.isWarmup) continue;

        if (s.reps != null) {
          reps = s.reps! > reps ? s.reps! : reps;
        }

        if (s.weight != null) {
          weight = s.weight! > weight ? s.weight! : weight;
        }

        if (exercise.workoutType == "Bodyweight") {
          _oneRepMax = reps > _oneRepMax ? reps : _oneRepMax;
        } else {
          double estimate = _estimateOneRepMax(weight, reps);

          _oneRepMax = estimate > _oneRepMax ? estimate : _oneRepMax;
        }
      }

      _values.add(_oneRepMax);
    }
  }

  void _calculateTotals(List<Exercise> exercises) {
    _values.clear();
    _repList.clear();
    _weightList.clear();

    for (final exercise in exercises) {
      double reps = 0;
      double weight = 0;

      for (final s in exercise.sets) {
        if (s.isWarmup) continue;

        if (s.reps != null) {
          reps += s.reps!;
        }

        if (s.weight != null) {
          weight += s.weight!;
        }
      }

      if (exercise.workoutType == "Bodyweight") {
        _oneRepMax = reps;
      } else {
        _oneRepMax = _estimateOneRepMax(weight, reps);
      }

      _values.add(_oneRepMax);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Workout> allWorkouts = List.from(ref.watch(workoutsProvider));
    List<Exercise> filteredExercises = [];

    if (allWorkouts.isNotEmpty) {
      allWorkouts.removeWhere((w) => w.isTemplate);
      allWorkouts.sort((a, b) => a.date.compareTo(b.date));

      for (final workout in allWorkouts) {
        filteredExercises.addAll(
          workout.exercises
              .where((exercise) => exercise.trackerID == widget.tracker.id),
        );
      }
    }

    if (filteredExercises.isEmpty) {
      return const SizedBox();
    }

    if (_dropdown == 'Top Set') {
      _calculateTopSet(filteredExercises);
    } else {
      _calculateTotals(filteredExercises);
    }

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextHeeboBold(text: widget.tracker.title, size: 18),
              ),
              Container(
                height: 35,
                width: 110,
                decoration: BoxDecoration(
                  color: AppColors.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MyDropdown(
                  value: _dropdown,
                  hint: '',
                  items: _dropdownValues
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: TextHeeboMedium(
                            text: value,
                            size: 12,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _dropdown = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(child: MyLineChart(data: _values)),
        ],
      ),
    );
  }
}
