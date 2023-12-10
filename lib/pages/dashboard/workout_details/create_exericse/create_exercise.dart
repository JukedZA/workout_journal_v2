import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/workout/exercise.dart';
import 'package:workout_journal_v2/models/workout/set.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/button_styles.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/my_form_field.dart';

class CreateExercise extends ConsumerStatefulWidget {
  final Workout workout;
  const CreateExercise({
    Key? key,
    required this.workout,
  }) : super(key: key);

  @override
  ConsumerState<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends ConsumerState<CreateExercise> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  int _setNumber = 0;

  void _createExercise() {
    final Exercise exercise = Exercise(
      id: const Uuid().v4(),
      title: _name,
      sets: List.generate(
        _setNumber,
        (index) => SetModel(id: const Uuid().v4(), weight: null, reps: null),
      ),
    );

    ref.read(workoutsProvider.notifier).addExercise(widget.workout, exercise);
  }

  void _addExercise() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _createExercise();

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextHeeboBold(
          text: 'New Exercise',
          size: 24,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyFormField(
                hintText: 'Exercise Name',
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter a name';
                  }
                },
                isNumbers: false,
                onSaved: (newValue) {
                  if (newValue != null && newValue.trim().isNotEmpty) {
                    _name = newValue;
                  }
                },
              ),
              const SizedBox(height: 25),
              MyFormField(
                hintText: 'Number of Sets',
                isNumbers: true,
                validator: (value) {
                  if (value != null &&
                      int.tryParse(value) != null &&
                      value.trim().isNotEmpty &&
                      int.tryParse(value)! > 0 &&
                      int.tryParse(value)! <= 20) {
                    return null;
                  } else {
                    return 'Enter a number between 1 and 20';
                  }
                },
                onSaved: (newValue) {
                  if (newValue != null &&
                      newValue.trim().isNotEmpty &&
                      int.tryParse(newValue) != null) {
                    _setNumber = int.tryParse(newValue)!;
                  }
                },
              ),
              const SizedBox(height: 25),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                    style: const RoundedButtonStyle(color: AppColors.redAccent)
                        .buildButtonStyle(),
                    onPressed: _addExercise,
                    child: const TextHeeboMedium(
                      text: 'Create',
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
