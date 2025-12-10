import 'package:flutter_application/core/constants/api_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortTypeNotifier extends Notifier<SortType> {
  @override
  SortType build() {
    return SortType.name;
  }

  void setSortType(SortType type) {
    state = type;
  }
}

final sortProductProvider = NotifierProvider<SortTypeNotifier, SortType>(() {
  return SortTypeNotifier();
});

