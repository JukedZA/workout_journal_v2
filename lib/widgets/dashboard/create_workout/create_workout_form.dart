import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/button_styles.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
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
          TextFormField(
            cursorColor: AppColors.secondaryText,
            validator: (value) {
              if (value != null && value.trim().isNotEmpty) {
                return null;
              } else {
                return 'Please enter a name';
              }
            },
            style: GoogleFonts.heebo(
              color: AppColors.primaryText,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.heebo(
                color: AppColors.secondaryText,
                fontSize: 15,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Workout Name',
              contentPadding: const EdgeInsets.all(18),
              filled: true,
              fillColor: AppColors.secondary,
            ),
            onSaved: (newValue) {
              if (newValue != null && newValue.trim().isNotEmpty) {
                _name = newValue;
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
                onPressed: () {
                  _submitForm();
                },
                child: const TextHeeboMedium(
                  text: 'Create',
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
