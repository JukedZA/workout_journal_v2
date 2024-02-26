import 'package:flutter/material.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/set.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/set_form_field.dart';

class SetItem extends StatefulWidget {
  final SetModel setItem;
  final int index;
  final void Function(SetModel setItem) saveSet;
  const SetItem({
    Key? key,
    required this.setItem,
    required this.index,
    required this.saveSet,
  }) : super(key: key);

  @override
  State<SetItem> createState() => _SetItemState();
}

class _SetItemState extends State<SetItem> {
  String _weight = '';
  String _reps = '';

  void _saveSet() {
    if (_weight.isEmpty && _reps.isEmpty) return;

    double? weight = double.tryParse(_weight);
    double? reps = double.tryParse(_reps);

    if (weight == null && reps == null) return;

    final SetModel newSet = SetModel(
      id: widget.setItem.id,
      weight: weight,
      reps: reps,
      isWarmup: widget.setItem.isWarmup,
    );

    widget.saveSet(newSet);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    Widget weightContent, repsContent;
    String? weight, reps;

    if (widget.setItem.reps == null && widget.setItem.weight == null) {
      weight = reps = null;
    } else if (widget.setItem.reps == null) {
      reps = null;
      weight = widget.setItem.weight!.toInt().toString();
    } else if (widget.setItem.weight == null) {
      weight = null;
      reps = widget.setItem.reps!.toInt().toString();
    } else {
      weight = widget.setItem.weight!.toInt().toString();
      reps = widget.setItem.reps!.toInt().toString();
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

    content = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        weightContent,
        const TextHeebo(
          text: 'reps of',
          size: 14,
          color: AppColors.secondaryText,
          weight: Weights.reg,
        ),
        repsContent,
        const TextHeebo(
          text: 'kg',
          size: 14,
          color: AppColors.secondaryText,
          weight: Weights.reg,
        ),
      ],
    );

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
