import 'package:flutter/material.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/body_items/buttons/dashboard_buttons.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/body_items/workout_container/dashboard_container.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        right: 25.0,
        left: 25.0,
        bottom: 25.0,
      ),
      child: Column(
        children: [
          DashboardButtons(),
          SizedBox(height: 16),
          DashboardContainer(),
        ],
      ),
    );
  }
}
