part of '../home_screen.dart';

class _GradientContainer extends StatelessWidget {
  final Color color;
  const _GradientContainer({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116.w,
      height: 121.h,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 14.h),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.r),
        ),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   width: double.infinity,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: 26.07,
          //         height: 26.07,
          //         padding: const EdgeInsets.symmetric(
          //             horizontal: 7.45, vertical: 3.72),
          //         decoration: ShapeDecoration(
          //           color: Colors.white.withOpacity(0.75),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(13.97),
          //           ),
          //         ),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Text(
          //               'U',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 color: Color(0xFF242424),
          //                 fontSize: 14.90,
          //                 fontFamily: 'Inter',
          //                 fontWeight: FontWeight.w600,
          //                 height: 20.86,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(height: 26.07),
          //       Container(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Text(
          //               'Upwork',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 11.17,
          //                 fontFamily: 'Inter',
          //                 fontWeight: FontWeight.w400,
          //                 height: 16.76,
          //               ),
          //             ),
          //             Text(
          //               '\$ 3,000',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16.76,
          //                 fontFamily: 'Inter',
          //                 fontWeight: FontWeight.w600,
          //                 height: 22.62,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _SavingsContainer extends StatelessWidget {
  // final double width;
  // final double height;
  const _SavingsContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: Assets.illustrations.savingsCard.provider(),
          fit: BoxFit.contain,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.10),
        ),
      ),
    );
  }
}
