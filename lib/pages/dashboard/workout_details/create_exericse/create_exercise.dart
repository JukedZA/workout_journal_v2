import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';
import 'package:workout_journal_v2/models/set/set.dart';
import 'package:workout_journal_v2/models/tracking/tracking_model.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/trackers/exercise_trackers.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/buttons/create_button.dart';
import 'package:workout_journal_v2/widgets/custom/drop_down.dart';
import 'package:workout_journal_v2/widgets/custom/form_fields/my_form_field.dart';
import 'package:workout_journal_v2/widgets/custom/my_switch.dart';

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
  bool _hasWarmup = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  int _setNumber = 0;
  int _warmupNumber = 0;

  String _selectedType = 'Barbell';
  String? _selectedTracker;

  String _newTrackerName = '';

  bool _newTracker = false;

  final List<String> _workoutTypes = [
    'Barbell',
    'Dumbbell',
    'Kettlebell',
    'Cables',
    'Machine',
    'Weighted',
    'Bodyweight',
  ];

  late List<Tracker> _trackers;

  void _createExercise() {
    final Exercise exercise = Exercise(
      id: const Uuid().v4(),
      title: _name,
      notes: '',
      hasNotes: false,
      workoutType: _selectedType,
      sets: [
        ...List.generate(
          _warmupNumber,
          (index) => SetModel(
            id: const Uuid().v4(),
            weight: null,
            reps: null,
            isWarmup: true,
          ),
        ),
        ...List.generate(
          _setNumber,
          (index) => SetModel(
            id: const Uuid().v4(),
            weight: null,
            reps: null,
            isWarmup: false,
          ),
        ),
      ],
      trackerID: _selectedTracker ?? '',
    );

    debugPrint(exercise.trackerID);

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
  void initState() {
    super.initState();

    _trackers = ref.read(trackersProvider);
  }

  @override
  Widget build(BuildContext context) {
    _trackers = ref.watch(trackersProvider);

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildExerciseContent(),
                _buildWarmupSwitch(),
                const SizedBox(height: 25),
                if (_hasWarmup) ..._buildWarmupContent(),
                CreateButton(
                  onPressed: _addExercise,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExerciseContent() {
    return [
      Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: MyDropdown(
                value: _selectedTracker,
                hint: 'No Exercise Tracker',
                items: [
                  if (_trackers.isNotEmpty)
                    ..._trackers
                        .map(
                          (Tracker item) => DropdownMenuItem<String>(
                            value: item.id,
                            child: TextHeeboMedium(
                              text: item.title,
                              size: 14,
                            ),
                          ),
                        )
                        .toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _selectedTracker = value;
                    }
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              setState(() {
                _newTracker = true;
              });
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      if (_newTracker)
        Column(
          children: [
            const SizedBox(height: 12),
            MyFormField(
              hintText: 'Tracker Name',
              suffixIcon: _newTrackerName.isEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _newTracker = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.secondaryText,
                        size: 24,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        if (_newTrackerName.isEmpty) return;

                        Tracker tracker = Tracker(
                          id: const Uuid().v4(),
                          title: _newTrackerName,
                        );

                        _newTracker = false;
                        _newTrackerName = '';

                        ref.read(trackersProvider.notifier).addTracker(tracker);
                      },
                      icon: const Icon(
                        Icons.save_rounded,
                        color: AppColors.secondaryText,
                        size: 20,
                      ),
                    ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _newTrackerName = newValue;
                  });
                }
              },
              validator: (value) {
                if (value != null && value.trim().isNotEmpty) {
                  return null;
                } else {
                  return 'Please enter a name';
                }
              },
              isNumbers: false,
              onSaved: (newValue) {},
            ),
          ],
        ),
      const SizedBox(height: 25),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: MyDropdown(
          value: _selectedType,
          hint: '',
          items: _workoutTypes
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: TextHeeboMedium(
                    text: item,
                    size: 14,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                _selectedType = value;
              }
            });
          },
        ),
      ),
      const SizedBox(height: 25),
      MyFormField(
        hintText: 'Exercise Name',
        suffixIcon: null,
        validator: (value) {
          if (value != null && value.trim().isNotEmpty) {
            return null;
          } else {
            return 'Please enter a name';
          }
        },
        onChanged: (newValue) {},
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
        suffixIcon: null,
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
        onChanged: (newValue) {},
        onSaved: (newValue) {
          if (newValue != null &&
              newValue.trim().isNotEmpty &&
              int.tryParse(newValue) != null) {
            _setNumber = int.tryParse(newValue)!;
          }
        },
      ),
      const SizedBox(height: 25),
    ];
  }

  Widget _buildWarmupSwitch() {
    return Row(
      children: [
        MySwitch(
          value: _hasWarmup,
          onChanged: (value) {
            setState(() {
              _hasWarmup = !_hasWarmup;
            });
          },
        ),
        const SizedBox(width: 8),
        const TextHeeboMedium(text: 'Add Warmup Sets', size: 16),
      ],
    );
  }

  List<Widget> _buildWarmupContent() {
    return [
      MyFormField(
        hintText: 'Number of Warmup Sets',
        suffixIcon: null,
        isNumbers: true,
        validator: (value) {
          if (value != null &&
              int.tryParse(value) != null &&
              value.trim().isNotEmpty &&
              int.tryParse(value)! > 0 &&
              int.tryParse(value)! <= 5) {
            return null;
          } else {
            return 'Enter a number between 1 and 5';
          }
        },
        onChanged: (newValue) {},
        onSaved: (newValue) {
          if (newValue != null &&
              newValue.trim().isNotEmpty &&
              int.tryParse(newValue) != null) {
            _warmupNumber = int.tryParse(newValue)!;
          }
        },
      ),
      const SizedBox(height: 25),
    ];
  }
}
