import 'package:flutter/material.dart';
import 'package:workout_journal_v2/widgets/dashboard/dash_nav.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/dashboard_body.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Center(
          child: DashboardNav(),
        ),
      ),
      body: DashboardBody(),
    );
  }
}
