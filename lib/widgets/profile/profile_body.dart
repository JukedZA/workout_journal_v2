import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/providers/profile/profile_name_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/my_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final String name = ref.watch(profileNameProvider);

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
          ],
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
