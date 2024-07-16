import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaagaz/l10n/l10n.dart';
import 'package:kaagaz/logging.dart';

import 'feature/db/db.dart';
import 'feature/l10n/l10n.dart';
import 'l10n/gen/app_localizations.dart';
import 'router.dart';
import 'serializers.dart';
import 'util/provider_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogging();
  await getAppDatabaseInstance();

  runApp(const ProviderScope(
    observers: [LoggingProviderObserver()],
    child: MainApp(),
  ));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    setupHandleJsonModelSerializer();
  }

  @override
  void reassemble() {
    super.reassemble();
    // update json model serializer on hot reload
    if (kDebugMode) {
      setupHandleJsonModelSerializer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      routerConfig: routerConfig,
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
      ],
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      // debug properties
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
    );
  }

  ThemeData buildTheme(BuildContext context) {
    final textTheme = GoogleFonts.jostTextTheme();
    final fontFamily = GoogleFonts.jost().fontFamily;

    ThemeData theme = FlexThemeData.light(
      scheme: FlexScheme.shark,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      appBarElevation: 0,
      subThemesData: const FlexSubThemesData(
        appBarCenterTitle: true,
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        splashType: FlexSplashType.instantSplash,
        defaultRadius: 4.0,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        tabBarDividerColor: Color(0x00000000),
        snackBarActionSchemeColor: SchemeColor.onPrimary,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      fontFamily: fontFamily,
    );

    theme = theme.copyWith(
        // customize theme here
        );

    return theme;
  }
}
