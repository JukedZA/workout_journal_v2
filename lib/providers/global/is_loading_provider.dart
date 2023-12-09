import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setLoading(bool b) {
    state = b;
  }
}

final isLoadingProvider = NotifierProvider<LoadingNotifier, bool>(
  () => LoadingNotifier(),
);
