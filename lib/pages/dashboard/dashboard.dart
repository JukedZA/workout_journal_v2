import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/widgets/custom/animations/page_animator.dart';
import 'package:workout_journal_v2/widgets/dashboard/dash_nav.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/dashboard_body.dart';
import 'package:workout_journal_v2/widgets/dashboard/drawer/drawer_items.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Center(
          child: DashboardNav(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
      body: const PageContainer(
        child: DashboardBody(),
      ),
      drawer: const Drawer(
        backgroundColor: AppColors.primary,
        surfaceTintColor: Colors.transparent,
        child: DrawerItems(),
      ),
    );
  }
}
