import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_journal_v2/data/global_data.dart';

class ProfileNameNotifier extends Notifier<String> {
  @override
  String build() {
    return Constants.name;
  }

  void changeName(String newName) {
    Constants.setName(newName);
    state = Constants.name;
  }
}

final profileNameProvider = NotifierProvider<ProfileNameNotifier, String>(
  () => ProfileNameNotifier(),
);
