import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../configs/app_launch_config.dart';

/// Initializes services and controllers before the start of the application
Future<ProviderContainer> initProviders() async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  ///Global provider container
  final ProviderContainer globalProviderContainer = ProviderContainer(
    overrides: <Override>[
      // sharedPrefsInstanceProvider.overrideWith((_) => preferences),
    ],
    // observers: <ProviderObserver>[if (kDebugMode) _ProviderLogger()],
  );
  await onAppLaunchConfig(globalProviderContainer);
  return globalProviderContainer;
}
