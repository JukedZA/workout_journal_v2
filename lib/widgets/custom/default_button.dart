import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/button_styles.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Color color;
  const DefaultButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: RoundedButtonStyle(color: color).buildButtonStyle(),
          onPressed: onPressed,
          child: TextHeeboMedium(
            text: title,
            size: 18,
          ),
        ),
      ),
    );
  }
}
