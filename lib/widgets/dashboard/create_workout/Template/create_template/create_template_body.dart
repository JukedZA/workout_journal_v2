import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/widgets/custom/buttons/create_button.dart';
import 'package:workout_journal_v2/widgets/custom/form_fields/my_form_field.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/Workout/create_workout_icon_button.dart';

class CreateTemplateForm extends ConsumerStatefulWidget {
  const CreateTemplateForm({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTemplateForm> createState() => _CreateTemplateFormState();
}

class _CreateTemplateFormState extends ConsumerState<CreateTemplateForm> {
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
        isTemplate: true,
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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  onChanged: (String? newValue) {},
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
          ),
        ],
      ),
    );
  }
}
