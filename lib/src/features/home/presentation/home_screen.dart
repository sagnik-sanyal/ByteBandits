import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/gen/assets.gen.dart';
import '../../../shared/text_widget.dart';
import '../../../utils/router_utils.dart';
import '../../view_payment_chart/presentation/view_payment_chart.dart';
import '../domain/models/transaction_model.dart';
import 'controllers/home_notifier.dart';
import 'state/home_state.dart';

part 'widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeNotifierProvider.notifier).refresh(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              toolbarHeight: 66.h,
              floating: true,
              pinned: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white.withOpacity(0.2),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(1, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (String value) {},
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10),
                          counterText: '',
                          hintText: 'Search for friends',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
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
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Flexible(
                      child: AppText.semiBold(
                        'Category Spending',
                        fontSize: 18,
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () =>
                            context.push(const ViewPaymentChartAnalysis()),
                        child: const AppText.semiBold(
                          'View All',
                          color: Color(0xFFF9ED90),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: const _CategoryListView(),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              sliver: const SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: AppText.semiBold(
                        'Compare Progress',
                        fontSize: 18,
                      ),
                    ),
                    Flexible(
                      child: AppText.semiBold(
                        'Leaderboard',
                        color: Color(0xFFF9ED90),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                width: 1.sw - 32.w,
                child: SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, int index) {
                      return SizedBox(
                        width: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.add_rounded),
                            ),
                            const Text.rich(
                              TextSpan(
                                text: 'Add',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(text: ' Friend'),
                                ],
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Flexible(
                      child: AppText.semiBold(
                        'All Transactions',
                        fontSize: 18,
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () =>
                            context.push(const ViewPaymentChartAnalysis()),
                        child: const AppText.semiBold(
                          'View All',
                          color: Color(0xFFF9ED90),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: const _AllTrans(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllTrans extends StatelessWidget {
  const _AllTrans();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final HomeState state = ref.watch(homeNotifierProvider);
      return state.maybeWhen(
        orElse: () => SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Assets.illustrations.noResults.image(
                height: 100,
                width: 100,
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
        loaded: (_, __, List<TransactionModel> v) {
          return SliverList.separated(
            itemCount: v.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, int index) => AllTransactionListTile(
              type: v[index].category,
              amount: v[index].amount,
              createdAt: DateFormat.yMMMd().format(v[index].createdAt!),
            ),
          );
        },
      );
    });
  }
}

class _CategoryListView extends StatelessWidget {
  const _CategoryListView();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final HomeState state = ref.watch(homeNotifierProvider);
      return state.maybeWhen(
        orElse: () => SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
        loaded: (CategoryList c, _, __) {
          return SliverList.separated(
            itemCount: c.data.take(5).length,
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
