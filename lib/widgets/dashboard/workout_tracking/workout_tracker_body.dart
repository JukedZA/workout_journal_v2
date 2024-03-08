import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/models/tracking/tracking_model.dart';
import 'package:workout_journal_v2/providers/trackers/exercise_trackers.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/drop_down.dart';
import 'package:workout_journal_v2/widgets/custom/no_items_found.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_tracking/tracker_item.dart';

class TrackerBody extends ConsumerStatefulWidget {
  const TrackerBody({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackerBody> createState() => _TrackerBodyState();
}

class _TrackerBodyState extends ConsumerState<TrackerBody> {
  List<Tracker> _selectedTrackers = [];

  @override
  void initState() {
    super.initState();
    _selectedTrackers = ref.read(currentTrackersProvider);
  }

  @override
  Widget build(BuildContext context) {
    List<Tracker> trackers = ref.watch(trackersProvider);

    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: MyDropdown(
              value: null,
              hint: 'Select A Tracker',
              items: trackers
                  .map(
                    (tracker) => DropdownMenuItem(
                      value: tracker.id,
                      enabled: false,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final isSelected =
                              _selectedTrackers.contains(tracker);
                          return InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              isSelected
                                  ? _selectedTrackers
                                      .removeWhere((t) => t.id == tracker.id)
                                  : _selectedTrackers.add(tracker);

                              ref
                                  .read(currentTrackersProvider.notifier)
                                  .setState(_selectedTrackers);

                              setState(() {});

                              menuSetState(() {});
                            },
                            child: SizedBox(
                              height: double.infinity,
                              child: Row(
                                children: [
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: AppColors.redAccent,
                                      size: 24,
                                    )
                                  else
                                    const Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.tertiary,
                                      size: 24,
                                    ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextHeeboMedium(
                                      text: tracker.title,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          if (_selectedTrackers.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NoItemsFound(
                      title: 'No Tracker Selected',
                      subtitle: 'Select a tracker to get started',
                    ),
                  ],
                ),
              ),
            ),
          if (_selectedTrackers.isNotEmpty)
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemBuilder: (context, index) => TrackerItem(
                    tracker: _selectedTrackers[index],
                  ),
                  itemCount: _selectedTrackers.length,
                ),
              ),
            )
        ],
      ),
    );
  }
}
