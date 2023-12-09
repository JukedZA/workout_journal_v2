import 'package:flutter/material.dart';
import 'package:workout_journal_v2/models/workout/set.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/set/set_item.dart';

class SetList extends StatelessWidget {
  final List<SetModel> sets;
  final void Function(SetModel setItem) saveSet;
  const SetList({
    Key? key,
    required this.sets,
    required this.saveSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sets.length,
      itemBuilder: (context, index) => SetItem(
        setItem: sets[index],
        index: index,
        saveSet: saveSet,
      ),
    );
  }
}
