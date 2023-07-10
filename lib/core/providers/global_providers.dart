import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<GlobalKey<NavigatorState>> navigatorKeyProvider =
    Provider<GlobalKey<NavigatorState>>(
  (ProviderRef<GlobalKey<NavigatorState>> ref) =>
      GlobalKey<NavigatorState>(debugLabel: 'navigatorKeyGlobal'),
);
