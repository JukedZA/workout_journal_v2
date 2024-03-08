import 'package:flutter/material.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/set/set.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/form_fields/set_form_field.dart';

class SetItem extends StatefulWidget {
  final SetModel setItem;
  final int index;
  final void Function(SetModel setItem) saveSet;
  final bool isBodyWeight;
  const SetItem({
    Key? key,
    required this.setItem,
    required this.index,
    required this.saveSet,
    required this.isBodyWeight,
  }) : super(key: key);

  @override
  State<SetItem> createState() => _SetItemState();
}

class _SetItemState extends State<SetItem> {
  String _weight = '';
  String _reps = '';

  void _saveSet() {
    double? weight = double.tryParse(_weight);
    double? reps = double.tryParse(_reps);

    final SetModel newSet = widget.setItem.copyWith(
      weight: weight,
      reps: reps,
    );

    widget.saveSet(newSet);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    Widget weightContent, repsContent;
    String? weight, reps;

    double? w = widget.setItem.weight;
    double? r = widget.setItem.reps;

    if (r == null && w == null) {
      weight = reps = null;
    } else if (r == null && w != null) {
      reps = null;
      weight = Methods.truncateDecimals(w);
    } else if (w == null && r != null) {
      weight = null;
      reps = Methods.truncateDecimals(r);
    } else {
      weight = Methods.truncateDecimals(w!);
      reps = Methods.truncateDecimals(r!);
    }

    weightContent = SetFormField(
      controller: null,
      initialValue: weight,
      onChanged: (newValue) {
        if (newValue != null) {
          _weight = newValue;
          _saveSet();
        }
      },
      onSaved: (newValue) {},
    );

    repsContent = SetFormField(
      controller: null,
      initialValue: reps,
      onChanged: (newValue) {
        if (newValue != null) {
          _reps = newValue;
          _saveSet();
        }
      },
      onSaved: (newValue) {},
    );

    if (!widget.isBodyWeight) {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          repsContent,
          const TextHeebo(
            text: 'reps of',
            size: 12,
            color: AppColors.secondaryText,
            weight: Weights.reg,
          ),
          weightContent,
          TextHeebo(
            text: Constants.weightUnit,
            size: 12,
            color: AppColors.secondaryText,
            weight: Weights.reg,
          ),
        ],
      );
    } else {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          repsContent,
          const TextHeebo(
            text: 'reps',
            size: 12,
            color: AppColors.secondaryText,
            weight: Weights.reg,
          ),
        ],
      );
    }

    if (widget.setItem.isWarmup) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          content,
          const TextHeebo(
            text: 'WARMUP',
            size: 10,
            color: AppColors.redAccent,
            weight: Weights.reg,
          ),
        ],
      );
    } else {
      return content;
    }
  }
}
