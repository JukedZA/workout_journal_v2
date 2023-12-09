import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_journal_v2/providers/workout/workout_filter_provider.dart';
import 'package:workout_journal_v2/theme/colors.dart';

class DashboardSearch extends ConsumerStatefulWidget {
  const DashboardSearch({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardSearch> createState() => _DashboardSearchState();
}

class _DashboardSearchState extends ConsumerState<DashboardSearch> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String filter = ref.watch(workoutFilterProvider);

    if (filter.isNotEmpty) {
      _isSearching = true;
    } else {
      _isSearching = false;
    }

    return TextField(
      controller: _controller,
      style: GoogleFonts.heebo(
        color: AppColors.primaryText.withOpacity(0.8),
        fontSize: 16,
        decorationColor: AppColors.secondaryText,
      ),
      cursorColor: AppColors.white,
      onChanged: (value) {
        if (value.isEmpty) {
          ref.read(workoutFilterProvider.notifier).setFilter('');
        } else {
          ref.read(workoutFilterProvider.notifier).setFilter(value);
        }
      },
      decoration: InputDecoration(
        prefixIconColor: AppColors.primaryText,
        suffixIconColor: AppColors.primaryText,
        hintStyle: GoogleFonts.rubik(
          color: AppColors.primaryText.withOpacity(0.8),
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: 'Search Workouts...',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        filled: true,
        fillColor: AppColors.secondary,
        prefixIcon: _isSearching == true
            ? IconButton(
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.close,
                  size: 25,
                ),
                color: AppColors.primaryText,
                onPressed: () {
                  _controller.clear();
                  ref.read(workoutFilterProvider.notifier).setFilter('');
                },
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.search,
                  color: AppColors.primaryText,
                  size: 25,
                ),
              ),
      ),
    );
  }
}
