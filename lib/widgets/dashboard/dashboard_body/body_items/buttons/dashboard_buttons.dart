import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/widgets/dashboard/dashboard_body/body_items/buttons/dashboard_search.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: DashboardSearch(),
        ),
        const SizedBox(width: 8),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.redAccent,
          ),
          child: IconButton(
            onPressed: () {
              context.goNamed(Routes.createWorkout);
            },
            style: const ButtonStyle(
              splashFactory: NoSplash.splashFactory,
            ),
            icon: const Icon(
              Icons.add_rounded,
              color: AppColors.white,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}
