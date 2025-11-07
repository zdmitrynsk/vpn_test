import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vpn_test/router/router.dart';
import 'package:vpn_test/ui/widgets/tab_bar_main.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AutoRouteObserver observer = GetIt.I<AutoRouteObserver>();
    return AutoTabsRouter.tabBar(
      navigatorObservers: () => [observer],
      routes: const [
        AllVpnsRoute(),
        MyVpnsRoute(),
        FavoriteVpnsRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(105),
              child: Column(
                children: [
                  _title(),
                  TabBarMain(controller: controller),
                ],
              ),
            ),
          ),
          body: child,
        );
      },
    );
  }

  Padding _title() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: const Text(
          'Точки доступа',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
