import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/gen/assets.gen.dart';
import '../../../shared/text_widget.dart';
import '../../auth/domain/models/user_model.dart';
import '../../home/domain/models/transaction_model.dart';
import '../../home/presentation/controllers/home_notifier.dart';
import '../../home/presentation/home_screen.dart';
import '../../home/presentation/state/home_state.dart';

class _CategoryListView extends StatelessWidget {
  const _CategoryListView();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final HomeState state = ref.watch(homeNotifierProvider);
      return state.maybeWhen(
        orElse: SliverToBoxAdapter.new,
        loaded: (CategoryList c, _, __) {
          return SliverList.separated(
            itemCount: c.data.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, int index) => TransactionLisTile(
              type: c.data[index].category ?? '--',
              amount: c.data[index].amount,
            ),
          );
        },
      );
    });
  }
}

class ViewPaymentChartAnalysis extends StatelessWidget {
  const ViewPaymentChartAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text('Past Transaction Analysis'),
          ),
          const _ScreenBody(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            sliver: const _CategoryListView(),
          ),
        ],
      ),
    );
  }
}

class _ScreenBody extends ConsumerWidget {
  const _ScreenBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeNotifierProvider);
    return SliverToBoxAdapter(
      child: state.maybeWhen(
        loaded: (CategoryList categorySpecificTransactions,
            List<UserModel> friends, _) {
          return AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sections: ref.read(homeNotifierProvider.notifier).pieCharts,
                centerSpaceRadius: 40.r,
              ),
            ),
          );
        },
        orElse: () => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            Assets.illustrations.noResults.image(
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            const AppText.bold(
              'No Results Found',
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
