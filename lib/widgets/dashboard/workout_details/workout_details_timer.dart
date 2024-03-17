import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';
import 'package:workout_journal_v2/widgets/custom/animations/item_animator.dart';
import 'package:workout_journal_v2/widgets/dashboard/workout_details/nav/workout_details_nav.dart';

class WorkoutDetailsTimer extends ConsumerStatefulWidget {
  final Workout workout;
  const WorkoutDetailsTimer({
    Key? key,
    required this.workout,
  }) : super(key: key);

  @override
  ConsumerState<WorkoutDetailsTimer> createState() =>
      _WorkoutDetailsTimerState();
}

class _WorkoutDetailsTimerState extends ConsumerState<WorkoutDetailsTimer> {
  String _duration = '00:00:00';

  DateTime _now = DateTime.now();
  late DateTime? _start;
  late DateTime? _end;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _start = widget.workout.startTime;
    _end = widget.workout.endTime;
    _duration = _calcTime();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _now = DateTime.now();
          _duration = _calcTime();
        });
      },
    );
  }

  String _calcTime() {
    if (_end != null && _start != null) {
      return _calcDuration(_start!, _end!);
    }

    if (_start != null) {
      return _calcDuration(_start!, _now);
    } else {
      return '00:00:00';
    }
  }

  String _calcDuration(DateTime start, DateTime end) {
    Duration duration = end.difference(start);

    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    final String formattedDuration =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconButton = IconItem(
      onTap: () {
        if (_start == null) {
          setState(() {
            _start = DateTime.now();
            _duration = _calcTime();
            _startTimer();
          });
        }
        ref.read(workoutsProvider.notifier).updateTime(_start, null);
      },
      icon: Icons.play_arrow_rounded,
    );

    if (_start != null && _end == null) {
      iconButton = IconItem(
        onTap: () {
          setState(() {
            _end = DateTime.now();
            _timer.cancel();
            _duration = _calcTime();
          });
          ref.read(workoutsProvider.notifier).updateTime(_start, _end);
        },
        icon: Icons.stop_rounded,
      );
    }

    if (_start != null && _end != null) {
      iconButton = Row(
        children: [
          IconItem(
            onTap: () {
              setState(() {
                final Duration duration = _end!.difference(_start!);

                _start = DateTime.now().subtract(duration);
                _end = null;
                _duration = _calcTime();
              });

              ref.read(workoutsProvider.notifier).updateTime(_start, null);

              _startTimer();
            },
            icon: Icons.play_arrow_rounded,
          ),
          const SizedBox(width: 4),
          SlideContainer(
            pos: Position.left,
            child: IconItem(
              onTap: () {
                setState(() {
                  _start = null;
                  _end = null;
                  _duration = '00:00:00';
                });
                ref.read(workoutsProvider.notifier).updateTime(null, null);
              },
              icon: Icons.restore_rounded,
            ),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconButton,
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const TextHeebo(
                text: 'Workout Length',
                size: 9,
                color: AppColors.secondaryText,
                weight: Weights.reg,
              ),
              TextHeebo(
                text: _duration,
                size: 20,
                weight: Weights.bold,
                color: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
