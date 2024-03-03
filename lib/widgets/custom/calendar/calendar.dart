import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/providers/workout/workout_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class MyCalendar extends ConsumerStatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  ConsumerState<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends ConsumerState<MyCalendar> {
  DateTime _now = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late List<Workout> _allWorkouts;

  @override
  void initState() {
    super.initState();

    _allWorkouts = ref.read(workoutsProvider);
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  // bool get _isBeforeToday {
  //   return _selectedDay!.isBefore(_now.subtract(const Duration(days: 1)));
  // }

  List<Workout> _getEventsForDay(DateTime day) {
    if (_allWorkouts.isNotEmpty) {
      return _allWorkouts.where((w) => isSameDay(w.date, day)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    _now = DateTime.now();
    _allWorkouts = ref.watch(workoutsProvider);

    return Column(
      children: [
        // CALENDAR
        buildCalendar(),
      ],
    );
  }

  /* //////////////////////////////// */
  /// FUNCTION FOR BUILDING THE CALENDAR
  /* //////////////////////////////// */
  Widget buildCalendar() {
    if (_allWorkouts.isNotEmpty) {
      _allWorkouts = _allWorkouts.where((w) => w.isTemplate == false).toList();
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.secondary, borderRadius: BorderRadius.circular(8)),
      child: TableCalendar(
        daysOfWeekVisible: false,
        headerVisible: false,
        daysOfWeekHeight: 30,
        enabledDayPredicate: (date) {
          return date.month == _focusedDay.month;
        },
        rowHeight: 30,
        calendarFormat: _calendarFormat,
        focusedDay: _focusedDay,
        eventLoader: _getEventsForDay,

        // START AT FIRST - END AT FIRST
        firstDay: DateTime(_now.year, _now.month, 1),
        lastDay: DateTime(_now.year, _now.month + 1, 0),

        // DISABLED SELECTING
        selectedDayPredicate: null,

        onDaySelected: _onDaySelected,

        // BUILDERS
        calendarBuilders: CalendarBuilders(
          // DISABLED BUILDER
          disabledBuilder: (context, day, focusedDay) {
            final hasWorkout = _getEventsForDay(day).isNotEmpty;
            final backgroundColor = hasWorkout
                ? AppColors.redAccent.withOpacity(0.1)
                : AppColors.tertiary.withOpacity(0.2);

            return Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },

          // MARKER BUILDER
          singleMarkerBuilder: (context, day, events) => const SizedBox(),

          // HEADER BUILDER
          headerTitleBuilder: (context, day) => const SizedBox(),

          // TODAY BUILDER
          todayBuilder: (context, day, focusedDay) => Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.redAccent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: TextHeeboBold(
                text: day.day.toString(),
                size: 10,
              ),
            ),
          ),

          // DEFAULT BUILDER
          defaultBuilder: (context, day, focusedDay) {
            final hasWorkout = _getEventsForDay(day).isNotEmpty;
            final backgroundColor =
                hasWorkout ? AppColors.redAccent : AppColors.tertiary;

            return Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: TextHeebo(
                  text: day.day.toString(),
                  size: 10,
                  color: AppColors.secondary.withOpacity(0.8),
                  weight: Weights.medium,
                ),
              ),
            );
          },

          // SELECTED BUILDER -> DISABLED
          selectedBuilder: (context, day, focusedDay) => const SizedBox(),
        ),
      ),
    );
  }
}
