import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/widgets/custom/buttons/default_button.dart';
import 'package:workout_journal_v2/widgets/custom/no_items_found.dart';
import 'package:workout_journal_v2/widgets/dashboard/create_workout/Template/template_item.dart';

class TemplateBody extends ConsumerStatefulWidget {
  const TemplateBody({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TemplateBody> createState() => _TemplateBodyState();
}

class _TemplateBodyState extends ConsumerState<TemplateBody> {
  List<bool> bools = [];

  void checkBools(List<Workout> templates) {
    if (bools.isEmpty || bools.length != templates.length) {
      setState(() {
        bools = List<bool>.generate(templates.length, (index) => false);
      });
    }
  }

  void onSelected(bool? b, int index) {
    if (b == null) return;

    setState(() {
      bools.fillRange(0, bools.length, false);
      bools[index] = b;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Workout> allWorkouts = ref.watch(workoutsProvider);
    List<Workout> templates = [];

    if (allWorkouts.isNotEmpty) {
      templates =
          allWorkouts.where((workout) => workout.isTemplate == true).toList();
    }

    checkBools(templates);

    if (templates.isEmpty) {
      return const NoItemsFound(
        title: 'No Templates Found',
        subtitle: 'Click the plus to create one',
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: templates.length,
              itemBuilder: (context, index) => Slidable(
                key: ValueKey(templates[index]),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 2 / 8,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 8),
                        child: GestureDetector(
                          onTap: () {
                            ref
                                .read(workoutsProvider.notifier)
                                .removeWorkout(templates[index]);

                            Methods.showToastMessage(
                              context,
                              AppColors.redAccent,
                              Icons.check_rounded,
                              'Template deleted successfully',
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_rounded,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                child: TemplateItem(
                  isSelected: bools[index],
                  onSelected: onSelected,
                  workout: templates[index],
                  index: index,
                ),
              ),
            ),
          ),
          if (bools.contains(true))
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DefaultButton(
                      title: 'Create',
                      onPressed: () {
                        final Workout workoutCopy =
                            templates[bools.indexOf(true)].copyWith(
                          id: const Uuid().v4(),
                          date: DateTime.now(),
                          isTemplate: false,
                        );

                        ref
                            .read(workoutsProvider.notifier)
                            .addItem(workoutCopy);
                        ref
                            .read(currentWorkoutProvider.notifier)
                            .setWorkout(workoutCopy);

                        Methods.showToastMessage(
                          context,
                          AppColors.greenAccent,
                          Icons.check_rounded,
                          'Workout created successfully',
                        );

                        context.goNamed(Routes.workoutDetails);
                      },
                      color: AppColors.redAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DefaultButton(
                      title: 'Edit',
                      onPressed: () {
                        final Workout workout = templates[bools.indexOf(true)];

                        ref
                            .read(currentWorkoutProvider.notifier)
                            .setWorkout(workout);
                        context.goNamed(Routes.templateDetails);
                      },
                      color: AppColors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
