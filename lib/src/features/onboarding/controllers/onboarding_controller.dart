import 'package:hooks_riverpod/hooks_riverpod.dart';

final AutoDisposeNotifierProvider<OnboardingIndexNotifier, int?>
    onboardingIndexProvider =
    NotifierProvider.autoDispose<OnboardingIndexNotifier, int?>(
  OnboardingIndexNotifier.new,
  name: 'onboardingIndexProvider',
);

class OnboardingIndexNotifier extends AutoDisposeNotifier<int?> {
  @override
  int? build() => 0;

  int get currentIndex => state ?? 0;

  void updateState(int? value) => state = value ?? 0;

  void increment() => state = state! + 1;
}
