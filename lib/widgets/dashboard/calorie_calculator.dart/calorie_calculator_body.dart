import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/widgets/custom/buttons/default_button.dart';
import 'package:workout_journal_v2/widgets/custom/drop_down.dart';
import 'package:workout_journal_v2/widgets/custom/form_fields/my_form_field.dart';

class CalorieCalculatorBody extends StatefulWidget {
  const CalorieCalculatorBody({Key? key}) : super(key: key);

  @override
  State<CalorieCalculatorBody> createState() => _CalorieCalculatorBodyState();
}

class _CalorieCalculatorBodyState extends State<CalorieCalculatorBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _currentGender;
  late String _currentFrequency;

  double _result = 0;

  String _age = '0';
  String _weight = '0';
  String _height = '0';

  final List<String> _genders = ['Male', 'Female'];

  final List<String> _workoutFrequency = [
    'Little to no exercise',
    'Light exercise 1-3 days/week',
    'Moderate exercise 3-5 days/week',
    'Hard exercise 6-7 days a week',
  ];

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      double? age = double.tryParse(_age);
      double? weight = double.tryParse(_weight);
      double? height = double.tryParse(_height);

      if (age == null || weight == null || height == null) return;

      double bmr = calculateBMR(weight, height, age, _currentGender);

      setState(() {
        _result = calculateTDEE(bmr, _currentFrequency, _currentFrequency);
      });

      context.goNamed(Routes.calorieResults, extra: _result);
    }
  }

  double calculateBMR(double weight, double height, double age, String gender) {
    if (gender == 'Male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  double calculateTDEE(
      double bmr, String activityLevel, String workoutFrequency) {
    final Map<String, double> activityFactors = {
      'Little to no exercise': 1.2,
      'Light exercise 1-3 days/week': 1.375,
      'Moderate exercise 3-5 days/week': 1.55,
      'Hard exercise 6-7 days a week': 1.725,
    };

    double activityFactor = activityFactors[activityLevel] ?? 1.0;
    bool isHighWorkoutFrequency =
        workoutFrequency == 'Hard exercise 6-7 days a week';

    double tdee = bmr * activityFactor + (isHighWorkoutFrequency ? 500 : 0);
    return tdee;
  }

  @override
  void initState() {
    super.initState();

    _currentGender = _genders.first;
    _currentFrequency = _workoutFrequency.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Physical Profile'),
              _formTitle('Age (16 - 70)'),
              MyFormField(
                hintText: 'Your Age',
                isNumbers: true,
                suffixIcon: null,
                validator: (value) {
                  if (value == '0' || value == null || value.isEmpty) {
                    return 'Please enter a value';
                  } else {
                    return null;
                  }
                },
                onChanged: (String? newValue) {},
                onSaved: (value) {
                  if (value != null) {
                    setState(() {
                      if (value.isEmpty) {
                        _age = '0';
                      } else {
                        _age = value;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 4),
              _formTitle('Weight (kg)'),
              MyFormField(
                hintText: 'Your Weight',
                isNumbers: true,
                suffixIcon: null,
                validator: (value) {
                  if (value == '0' || value == null || value.isEmpty) {
                    return 'Please enter a value';
                  } else {
                    return null;
                  }
                },
                onChanged: (String? newValue) {},
                onSaved: (value) {
                  if (value != null) {
                    setState(() {
                      if (value.isEmpty) {
                        _weight = '0';
                      } else {
                        _weight = value;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 4),
              _formTitle('Height (cm)'),
              MyFormField(
                hintText: 'Your Height',
                isNumbers: true,
                suffixIcon: null,
                onChanged: (String? newValue) {},
                validator: (value) {
                  if (value == '0' || value == null || value.isEmpty) {
                    return 'Please enter a value';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  if (value != null) {
                    setState(() {
                      if (value.isEmpty) {
                        _height = '0';
                      } else {
                        _height = value;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 4),
              _formTitle(''),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MyDropdown(
                  value: _currentGender,
                  hint: '',
                  items: _genders
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentGender = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),
              _title('Activity Details'),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MyDropdown(
                  value: _currentFrequency,
                  hint: '',
                  items: _workoutFrequency
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentFrequency = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),
              DefaultButton(
                title: 'Calculate',
                onPressed: () {
                  _calculate();
                },
                color: AppColors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: GoogleFonts.heebo(
          color: AppColors.secondaryText,
          fontSize: 16,
          fontWeight: Weights.medium,
        ),
      ),
    );
  }

  Widget _formTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: GoogleFonts.heebo(
          color: AppColors.tertiary,
          fontStyle: FontStyle.italic,
          fontSize: 10,
        ),
      ),
    );
  }
}
