import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/vpns_catalog_repository.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/vpns_catalog_repository_i.dart';
import 'package:vpn_test/router/router.dart';
import 'package:vpn_test/ui/theme/theme.dart';

void main() {
  _registerDependecies();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MainApp(),
    ),
  );
}

void _registerDependecies() {
  GetIt di = GetIt.I;
  di.registerSingleton<VpnCatalogRepositoryI>(VpnCatalogRepository());
  di.registerSingleton(AutoRouteObserver());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: appTheme,
      routerConfig: appRouter.config(),
    );
  }
}
