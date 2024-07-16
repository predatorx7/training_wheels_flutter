import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screen/error/error.dart';
import 'screen/home/home.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final RouterConfig<Object> routerConfig = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: kDebugMode,
  errorBuilder: AppErrorScreen.errorBuilder,
  routes: [
    HomeScreen.navigation.route,
  ],
);
