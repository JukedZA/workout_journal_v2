import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/models/exercise/exercise.dart';
import 'package:workout_journal_v2/models/set/set.dart';
import 'package:workout_journal_v2/models/tracking/tracking_model.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/services/navigation_router.dart';
import 'package:workout_journal_v2/theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(SetModelAdapter());
  Hive.registerAdapter(TrackerAdapter());

  await Hive.openBox('all-workouts');

  Constants.workoutBox = Hive.box('all-workouts');

  if (Constants.workoutBox.get(BoxNames.workouts) != null) {
    List<dynamic> storedWorkouts = Constants.workoutBox.get(BoxNames.workouts);
    if (storedWorkouts.isNotEmpty) {
      Constants.setWorkoutList(storedWorkouts.cast<Workout>());
    } else {
      Constants.setWorkoutList(<Workout>[]);
    }
  } else {
    Constants.setWorkoutList(<Workout>[]);
  }

  if (Constants.workoutBox.get(BoxNames.trackers) != null) {
    List<dynamic> storedTrackers = Constants.workoutBox.get(BoxNames.trackers);
    if (storedTrackers.isNotEmpty) {
      Constants.setTrackerList(storedTrackers.cast<Tracker>());
    } else {
      Constants.setTrackerList(<Tracker>[]);
    }
  } else {
    Constants.setTrackerList(<Tracker>[]);
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.primary,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: const MaterialStatePropertyAll(AppColors.tertiary),
        ),
        cardColor: Colors.transparent,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: AppColors.white,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      routerConfig: NavigationRouter.router,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler
            .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.05);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: scale),
          child: child!,
        );
      },
    );
  }
}
