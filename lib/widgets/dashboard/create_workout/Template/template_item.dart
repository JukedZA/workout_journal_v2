import 'package:flutter/material.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class TemplateItem extends StatelessWidget {
  final Workout workout;
  final void Function(bool?, int) onSelected;
  final bool isSelected;
  final int index;
  const TemplateItem({
    Key? key,
    required this.workout,
    required this.isSelected,
    required this.onSelected,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        onSelected(!isSelected, index);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.tertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/images/${workout.img}'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: TextHeeboBold(text: workout.title, size: 18)),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              size: 28,
              color: isSelected ? AppColors.redAccent : AppColors.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
