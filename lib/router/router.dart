import 'package:auto_route/auto_route.dart';
import 'package:vpn_test/features/screens/favorites_vpns/view/favorites_vpns_screen.dart';
import 'package:vpn_test/features/screens/my_vpns/view/my_vpns_screen.dart';
import 'package:vpn_test/features/screens/home/view/home_screen.dart';
import 'package:vpn_test/features/screens/all_vpns/view/all_vpns_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(page: AllVpnsRoute.page, path: 'all'),
            AutoRoute(page: MyVpnsRoute.page, path: 'my_vpn'),
            AutoRoute(page: FavoriteVpnsRoute.page, path: 'favorite_vpn'),
          ],
        ),
      ];
}
