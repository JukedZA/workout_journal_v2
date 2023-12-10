import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/my_form_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';

  bool _isLoading = false;

  Future<void> _submitInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('name', _name);

      _login(_name);
    }
  }

  void _login(String name) {
    Constants.setName(name);
    context.goNamed(Routes.dashboard);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                child: Image.asset('assets/images/workout-journal.png',
                    width: MediaQuery.of(context).size.width * 0.6),
              ),
            ),
            const SizedBox(height: 25),
            // TextHeeboMedium(text: 'What can we call you?', size: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: MyFormField(
                hintText: 'Display Name',
                isNumbers: false,
                suffixIcon: null,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'We need something to call you';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _name = newValue!;
                },
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: _submitInfo,
                  child: _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : const TextHeeboMedium(
                          text: 'Create',
                          size: 18,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
