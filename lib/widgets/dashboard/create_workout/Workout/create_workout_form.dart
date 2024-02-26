import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/create_button.dart';
import 'package:workout_journal_v2/widgets/custom/my_form_field.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/create_workout_icon_button.dart';

class CreateWorkoutForm extends ConsumerStatefulWidget {
  const CreateWorkoutForm({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateWorkoutForm> createState() => _CreateWorkoutFormState();
}

class _CreateWorkoutFormState extends ConsumerState<CreateWorkoutForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> imgs = [
    true,
    false,
    false,
    false,
    false,
  ];

  String _name = '';
  String _img = 'arms.png';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_img.isEmpty) return;

      Workout workout = Workout(
        id: const Uuid().v4(),
        title: _name,
        img: _img,
        date: DateTime.now(),
        exercises: [],
        isTemplate: false,
      );

      ref.read(workoutsProvider.notifier).addItem(workout);

      context.pop();
    }
  }

  void setImage(int index) {
    setState(() {
      for (int i = 0; i < imgs.length; i++) {
        imgs[i] = false;
      }

      imgs[index] = true;

      switch (index) {
        case 0:
          _img = 'arms.png';
          break;
        case 1:
          _img = 'shoulders.png';
          break;
        case 2:
          _img = 'legs.png';
          break;
        case 3:
          _img = 'back.png';
          break;
        case 4:
          _img = 'chest.png';
          break;
        default:
          _img = 'arms.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTemplateSection(),
          const SizedBox(height: 16),
          Text(
            'Click To Select Icon*',
            style: GoogleFonts.heebo(
              color: AppColors.tertiary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CreateWorkoutIconButton(
                  img: 'assets/images/arms.png',
                  onTap: setImage,
                  index: 0,
                  isSelected: imgs[0],
                ),
                CreateWorkoutIconButton(
                  img: 'assets/images/shoulders.png',
                  onTap: setImage,
                  index: 1,
                  isSelected: imgs[1],
                ),
                CreateWorkoutIconButton(
                  img: 'assets/images/legs.png',
                  onTap: setImage,
                  index: 2,
                  isSelected: imgs[2],
                ),
                CreateWorkoutIconButton(
                  img: 'assets/images/back.png',
                  onTap: setImage,
                  index: 3,
                  isSelected: imgs[3],
                ),
                CreateWorkoutIconButton(
                  img: 'assets/images/chest.png',
                  onTap: setImage,
                  index: 4,
                  isSelected: imgs[4],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          MyFormField(
            hintText: 'Workout Name',
            isNumbers: false,
            suffixIcon: null,
            validator: (value) {
              if (value != null && value.trim().isNotEmpty) {
                return null;
              } else {
                return 'Please enter a name';
              }
            },
            onSaved: (newValue) {
              if (newValue != null && newValue.trim().isNotEmpty) {
                _name = newValue;
              }
            },
          ),
          const SizedBox(height: 25),
          CreateButton(
            onPressed: () {
              _submitForm();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateSection() {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        context.goNamed(Routes.workoutTemplates);
      },
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.tertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.file_copy,
                      color: AppColors.redAccent,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const TextHeebo(
                    text: 'Your Templates',
                    color: AppColors.primaryText,
                    size: 16,
                    weight: Weights.bold,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
