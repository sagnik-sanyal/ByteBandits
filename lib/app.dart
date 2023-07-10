import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/providers/global_providers.dart';
import 'src/features/auth/presentation/controller/auth_controller.dart';
import 'src/features/home/presentation/home_screen.dart';
import 'src/features/onboarding/screens/onboarding_screen.dart';
import 'src/features/qr_scanner/presentation/qr_scanner_screen.dart';

class RootWidget extends ConsumerWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          navigatorKey: ref.watch(navigatorKeyProvider),
          theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF080808),
              scrolledUnderElevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0,
            ),
            textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            scaffoldBackgroundColor: const Color(0xFF080808),
          ),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/qr': (BuildContext context) => const QrScannerScreen(),
            '/home': (BuildContext context) => const HomeScreen(),
          },
          home: const _AuthChecker(key: Key('authChecker')),
        );
      },
    );
  }
}

class _AuthChecker extends StatelessWidget {
  const _AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: Scaffold(
        body: Center(
          child: RepaintBoundary(
            child: SizedBox.square(
              dimension: 40.h,
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final AsyncValue<bool> state = ref.watch(isLoggedInProvider);
        return state.maybeWhen(
          orElse: () => child!,
          data: (bool isLoggedIn) {
            if (isLoggedIn) {
              return const HomeScreen();
            }
            return const OnboardingScreen();
          },
        );
      },
    );
  }
}
