import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app/gen/assets.gen.dart';
import '../../../shared/text_widget.dart';
import '../controllers/onboarding_controller.dart';

part 'widgets/widgets.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController = usePageController();
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Assets.illustrations.abstract.image(
              fit: BoxFit.cover,
              height: 200.h,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 1.sh - 200.h,
                  maxWidth: double.infinity,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: 3,
                        onPageChanged: (int v) => ref
                            .read(onboardingIndexProvider.notifier)
                            .updateState(v),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Assets.illustrations.o1.image(
                                fit: BoxFit.fitHeight,
                                height: 300.h,
                              ),
                              const SizedBox(height: 50),
                              Text.rich(
                                const TextSpan(
                                  text: 'Welcome to ',
                                  children: <InlineSpan>[
                                    TextSpan(text: 'FinGo')
                                  ],
                                ),
                                style: TextStyle(
                                  fontSize: 26.spMin,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 44.w).add(
                                  EdgeInsets.only(bottom: 16.h, top: 27.h),
                                ),
                                child: Text.rich(
                                  const TextSpan(
                                    text: 'Weekly Insights for Wiser Spending',
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' and Greater Savings',
                                      )
                                    ],
                                  ),
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: const Color(0xFFBDBDBD),
                                    fontSize: 16.spMin,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const _TabIndicator(
                        key: ValueKey<String>('tab_indicator'),
                      ),
                    ),
                    _NextButton(
                      key: const ValueKey<String>('next_button'),
                      onPressed: () => pageController.nextPage(
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
