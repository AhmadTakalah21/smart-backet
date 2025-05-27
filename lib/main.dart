import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:provider/provider.dart';

import 'core/configuration/styles.dart';
import 'core/routing/route_path.dart';
import 'core/routing/router.dart';
import 'core/shared_preferences/shared_preferences_instance.dart';
import 'generated/l10n.dart';
import 'injection_container.dart';
import 'l10n/l10n.dart';
import 'l10n/local_provider.dart';

void main() async {
  initInjection();
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesInstance().init();
  await sl<LocaleProvider>().fetchLocale();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<LocaleProvider>()),
        ChangeNotifierProvider(create: (context) => sl<AppState>()),
      ],
      builder: (context, provider) {
        final localizationProvider = Provider.of<LocaleProvider>(context);
        return ScreenUtilInit(
          designSize: Size(1080, 1920),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Styles.colorPrimary, brightness: Brightness.dark),
              useMaterial3: true,
              iconTheme: IconThemeData(color: Colors.white),
              //appBarTheme: AppBarTheme(backgroundColor: Styles.backgroundColor),
              //scaffoldBackgroundColor: Styles.backgroundColor,
              inputDecorationTheme: Styles.inputDecorationStyle.copyWith(
                  fillColor: ColorScheme.fromSeed(
                          seedColor: Styles.colorPrimary,
                          brightness: Brightness.dark)
                      .background),
            ),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              physics: const BouncingScrollPhysics(),
            ),
            supportedLocales: L10n.all,
            locale: localizationProvider.locale,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: RoutePaths.SplashScreen,
          ),
        );
      },
    );
  }
}
