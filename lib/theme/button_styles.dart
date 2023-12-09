import 'package:flutter/material.dart';

////////* Rounded Square with Border /////////

class RoundedBorderStyle {
  final Color color;
  const RoundedBorderStyle({
    Key? key,
    required this.color,
  });

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 8,
        ),
      ),
      surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class RoundedButtonStyle {
  final Color color;
  const RoundedButtonStyle({
    Key? key,
    required this.color,
  });

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 8,
        ),
      ),
      surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
      backgroundColor: MaterialStatePropertyAll(color),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
