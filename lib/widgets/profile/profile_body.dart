import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/profile/profile_name_provider.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/calendar/calendar.dart';
import 'package:workout_journal_v2/widgets/custom/form_fields/my_form_field.dart';

class ProfileBody extends ConsumerStatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ConsumerState<ProfileBody> {
  final _formKey = GlobalKey<FormState>();

  String _newName = '';

  Future<void> _setName() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _newName);

    ref.read(profileNameProvider.notifier).changeName(_newName);
  }

  Future<void> _saveName() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _setName();

      if (context.mounted) {
        Methods.showToastMessage(context, AppColors.greenAccent,
            Icons.check_rounded, 'Name Changed Successfully');
      }
    }
  }

  int _weeklyWorkouts(List<Workout> workouts) {
    if (workouts.isEmpty) return 0;

    final DateTime now = DateTime.now();
    final DateTime oneWeekAgo = now.subtract(const Duration(days: 7));

    List<Workout> weeklyWorkouts = workouts
        .where(
          (w) => w.date.isAfter(oneWeekAgo) && w.isTemplate == false,
        )
        .toList();

    return weeklyWorkouts.length;
  }

  @override
  Widget build(BuildContext context) {
    final String name = ref.watch(profileNameProvider);
    List<Workout> workouts = ref.watch(workoutsProvider);

    if (workouts.isNotEmpty) {
      workouts = workouts.where((w) => w.isTemplate == false).toList();
    }

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileItem('Change Name', Icons.person_rounded),
            const SizedBox(height: 16),
            MyFormField(
              hintText: name,
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                onPressed: _saveName,
                icon: const Icon(
                  Icons.save_rounded,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
              onChanged: (String? newValue) {},
              isNumbers: false,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name cannot be empty';
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                if (newValue == null || newValue.trim().isEmpty) return;
                _newName = newValue;
              },
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                buildProfileItem('Workout Info', Icons.info_outline_rounded),
                const SizedBox(height: 16),
                Row(
                  children: [
                    buildStatContainer('Total', workouts.length),
                    const SizedBox(width: 8),
                    buildStatContainer(
                        'Last 7 Days', _weeklyWorkouts(workouts)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                buildProfileItem('Activity Log', Icons.calendar_month),
                const SizedBox(height: 16),
                const MyCalendar(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatContainer(String title, int length) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextHeebo(
                text: title,
                size: 12,
                color: AppColors.secondaryText,
                weight: Weights.medium,
              ),
              const SizedBox(height: 8),
              TextHeebo(
                text: length.toString(),
                size: 22,
                color: AppColors.white,
                weight: Weights.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileItem(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.redAccent,
          size: 16,
        ),
        const SizedBox(width: 4),
        TextHeebo(
          text: title,
          size: 16,
          color: AppColors.redAccent,
          weight: Weights.medium,
        ),
      ],
    );
  }
}
