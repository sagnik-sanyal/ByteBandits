part of 'package:bytebandits/src/features/onboarding/screens/onboarding_screen.dart';

class _NextButton extends ConsumerWidget {
  final void Function()? onPressed;
  const _NextButton({Key? key,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int val = ref.watch(onboardingIndexProvider) ?? 0;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: val == 2
          ? ElevatedButton.icon(
              onPressed: () {},
              key: const ValueKey<String>('google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
              ),
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Color(0xFFFFCD52),
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: AppText.bold(
                  'Sign in with Google',
                  fontSize: 16,
                  color: Color(0xFF080808),
                ),
              ),
            )
          : ElevatedButton(
              key: const ValueKey<String>('next'),
              onPressed: () =>
                  ref.read(onboardingIndexProvider.notifier).increment(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
              ),
              child: const AppText.bold(
                'Next',
                fontSize: 16,
                color: Color(0xFF080808),
              ),
            ),
    );
  }
}

class _TabIndicator extends ConsumerWidget {
  const _TabIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int val = ref.watch(onboardingIndexProvider) ?? 0;
    return AnimatedSmoothIndicator(
      activeIndex: val,
      count: 3,
      effect: const ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        dotColor: Color(0xFFBDBDBD),
        activeDotColor: Color(0xFFFFCD52),
        expansionFactor: 2,
        spacing: 8,
      ),
    );
  }
}
