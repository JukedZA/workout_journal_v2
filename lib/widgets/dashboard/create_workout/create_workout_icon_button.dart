import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class CreateWorkoutIconButton extends StatelessWidget {
  final String img;
  final void Function(int i) onTap;
  final int index;
  final bool isSelected;
  const CreateWorkoutIconButton({
    Key? key,
    required this.img,
    required this.onTap,
    required this.index,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        onTap(index);
      },
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.tertiary : AppColors.secondary,
        ),
        child: Image.asset(img),
      ),
    );
  }
}
