import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class MyDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<DropdownMenuItem> items;
  final void Function(dynamic value) onChanged;
  final List<Widget> Function(BuildContext context)? selectedBuilder;
  const MyDropdown({
    Key? key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.selectedBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      underline: const SizedBox(),
      isExpanded: true,
      hint: TextHeeboMedium(
        text: hint,
        size: 14,
      ),
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.secondaryText,
            size: 20,
          ),
        ),
      ),
      buttonStyleData: const ButtonStyleData(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        isOverButton: false,
        offset: const Offset(0, -5),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      selectedItemBuilder: selectedBuilder,
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
