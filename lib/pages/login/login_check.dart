import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/pages/dashboard/dashboard.dart';
import 'package:workout_journal_v2/pages/login/login.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({Key? key}) : super(key: key);

  Future<Widget> checkPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final String? name = prefs.getString('name');

    if (name == null || name.isEmpty) {
      return const LoginPage();
    } else {
      Constants.setName(name);
      return const Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkPrefs(),
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the Future is still running, show a loading indicator or something
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.redAccent,
          ));
        } else {
          // When the Future completes, either show the LoginPage or Dashboard
          return snapshot.data ?? const LoginPage();
        }
      },
    );
  }
}
