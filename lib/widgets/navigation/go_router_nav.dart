import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/button_styles.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: navigationShell,
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
      barrierColor: AppColors.secondary.withOpacity(0.7),
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.primary,
        title: const TextHeeboMedium(
          text: 'Exit App',
          size: 20,
        ),
        content: const TextHeeboReg(
          text: 'Are you sure?',
          size: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsPadding: const EdgeInsets.all(16),
        actions: [
          TextButton(
            style: const RoundedBorderStyle(color: AppColors.secondary)
                .buildButtonStyle(),
            onPressed: () {
              context.pop(false);
            },
            child: const TextHeebo(
              text: 'No',
              size: 12,
              weight: Weights.reg,
              color: AppColors.primaryText,
            ),
          ),
          TextButton(
            style: const RoundedBorderStyle(color: AppColors.secondary)
                .buildButtonStyle(),
            onPressed: () {
              context.pop(true);
            },
            child: const TextHeebo(
              text: 'Yes',
              size: 12,
              weight: Weights.reg,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );

    return exitApp ?? false;
  }
}
