import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class MyDropdown extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem> items;
  final void Function(dynamic value) onChanged;
  const MyDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      underline: const SizedBox(),
      isExpanded: true,
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ),
      buttonStyleData: const ButtonStyleData(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
