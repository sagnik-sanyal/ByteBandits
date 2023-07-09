import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/features/auth/presentation/controller/auth_controller.dart';
import 'src/features/onboarding/screens/onboarding_screen.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();

  @override
  void initState() {
    super.initState();
    cfPaymentGatewayService.setCallback(
      verifyPayment,
      onError,
      (String p0, Map p1) {
        log(jsonEncode(p1));
      },
    );
  }

  @override
  void dispose() {
    // cfPaymentGatewayService.
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
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
          home: Consumer(
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
                    return const Scaffold(
                      body: Center(child: Text('Authenticated')),
                    );
                  }
                  return const OnboardingScreen();
                },
              );
            },
          ),
        );
      },
    );
  }

  void verifyPayment(String orderId) {
    print('Verify Payment');
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    print(errorResponse.getMessage());
    print('Error while making payment');
  }

  String orderId = 'order_8369';
  String paymentSessionId =
      'session_hEMBgGq3nLJOZq4HPA4foW1doXbZTFvJrCTetTI-6aqSccS58eDv5YJ6d3QflIef7NqYJ7xvrOqw5nUu8U416sKGUM1IoGlo5EYnbjpcSuoz';
  CFEnvironment environment = CFEnvironment.SANDBOX;

  CFSession? createSession() {
    try {
      CFSession session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();

      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

  pay() async {
    try {
      CFSession? session = createSession();
      List<CFPaymentModes> components = <CFPaymentModes>[
        CFPaymentModes.UPI,
      ];
      CFPaymentComponent paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();

      CFTheme theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor('#FF0000')
          .setPrimaryFont('Menlo')
          .setSecondaryFont('Futura')
          .build();

      CFDropCheckoutPayment cfDropCheckoutPayment =
          CFDropCheckoutPaymentBuilder()
              .setSession(session!)
              .setPaymentComponent(paymentComponent)
              .setTheme(theme)
              .build();

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }
}
