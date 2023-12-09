import 'package:flutter/material.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class DashboardNav extends StatelessWidget {
  const DashboardNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      toolbarHeight: 80,
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_rounded,
              color: AppColors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextHeeboBold(text: 'Hello ${Constants.name},', size: 24),
              const TextHeebo(
                text: 'Your Workouts',
                color: AppColors.redAccent,
                weight: Weights.medium,
                size: 14,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.redAccent,
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.secondary,
            size: 25,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
