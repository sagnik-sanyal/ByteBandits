import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/gen/assets.gen.dart';
import '../../../shared/text_widget.dart';
import '../../../utils/router_utils.dart';

part 'widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.medium(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Flexible(child: Text('Home')),
                IconButton(
                  onPressed: () async {
                    while (!(await Permission.camera.isGranted)) {
                      await Permission.camera.request();
                    }
                    if (context.mounted) {
                      await context.pushNamed('/qr');
                    }
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                ),
              ],
            ),
          ),
          _buildHeaderRow(text: 'Savings', showDivider: false),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,

              // mainAxisSpacing: 14.h,
              // crossAxisSpacing: 14.w,
              childAspectRatio: 1.0,
            ),
            itemCount: 4,
            itemBuilder: (_, int index) => const _SavingsContainer(),
          ),
          _buildHeaderRow(text: 'Top Categories'),
          const SliverToBoxAdapter(
            child: _GradientContainer(
              color: Color(0xFFE0533D),
            ),
          )
        ],
      ),
    );
  }

  SliverPadding _buildHeaderRow({
    required String text,
    String actionText = 'View All',
    bool showDivider = true,
  }) =>
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        sliver: SliverToBoxAdapter(
          child: showDivider
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: AppText.semiBold(
                            text,
                            fontSize: 20,
                          ),
                        ),
                        Flexible(
                          child: AppText.semiBold(
                            actionText,
                            color: const Color(0xFFF9ED90),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: AppText.semiBold(
                        text,
                        fontSize: 20,
                      ),
                    ),
                    Flexible(
                      child: AppText.semiBold(
                        actionText,
                        color: const Color(0xFFF9ED90),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
        ),
      );
}
