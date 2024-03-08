import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/button_styles.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class CreateButton extends StatelessWidget {
  final void Function()? onPressed;
  const CreateButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextButton(
          style: const RoundedButtonStyle(color: AppColors.redAccent)
              .buildButtonStyle(),
          onPressed: onPressed,
          child: const TextHeeboMedium(
            text: 'Create',
            size: 18,
          ),
        ),
      ),
    );
  }
}
