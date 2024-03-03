import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';
import 'package:workout_journal_v2/models/set/set.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/exercise/exercise_item_form.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/set/set_list.dart';

class ExerciseItem extends ConsumerStatefulWidget {
  final Exercise exercise;
  const ExerciseItem({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  ConsumerState<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends ConsumerState<ExerciseItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.exercise.notes;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _setNotes(bool hasNotes) {
    final Exercise newExercise = widget.exercise.copyWith(
      hasNotes: hasNotes,
      notes: _notesController.text,
    );

    ref.read(workoutsProvider.notifier).replaceExercise(newExercise);
  }

  void _saveNotes() {
    final List<Workout> allWorkouts = ref.watch(workoutsProvider);

    ref
        .read(currentWorkoutProvider.notifier)
        .saveNotes(widget.exercise, _notesController.text);

    Constants.workoutBox.put('workouts', allWorkouts);

    // setState(() {});
  }

  void _createSet(SetModel setItem) {
    final List<Workout> allWorkouts = ref.watch(workoutsProvider);

    ref.read(currentWorkoutProvider.notifier).saveSet(
          setItem,
          widget.exercise,
        );

    Constants.workoutBox.put('workouts', allWorkouts);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: AppColors.tertiary,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHeeboBold(text: widget.exercise.title, size: 16),
                      const SizedBox(height: 4),
                      TextHeebo(
                        text: widget.exercise.workoutType.toUpperCase(),
                        size: 10,
                        color: AppColors.secondaryText,
                        weight: Weights.reg,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      _setNotes(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.redAccent,
                      ),
                      child: const Row(
                        children: [
                          TextHeebo(
                            text: 'Notes',
                            size: 12,
                            color: AppColors.secondaryText,
                            weight: Weights.medium,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.add_rounded,
                            color: AppColors.secondaryText,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (widget.exercise.hasNotes)
              ExerciseItemForm(
                onTap: () {
                  _setNotes(false);
                },
                onEditingComplete: () {
                  // _saveNotes();
                },
                onChanged: (value) {
                  _saveNotes();
                },
                controller: _notesController,
              ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
              child: SetList(
                isBodyWeight:
                    widget.exercise.workoutType.toLowerCase() == 'bodyweight'
                        ? true
                        : false,
                sets: widget.exercise.sets,
                saveSet: _createSet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
