import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:silver_touch_task/modules/dashboard/contact/bloc/contact_bloc.dart';

import 'modules/core/utils/common_import.dart';
import 'modules/dashboard/category/bloc/add_category_bloc.dart';
import 'modules/dashboard/category/bloc/category_bloc.dart';
import 'modules/dashboard/contact/bloc/add_contact_bloc.dart';
import 'modules/splash/view/screen_splash.dart';

/// Used by [MyApp] StatefulWidget for init of app
///[MultiProvider] A provider that merges multiple providers into a single linear widget tree.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppWidget();
  }
}

///[MaterialAppWidget] This class use to Material App Widget
class MaterialAppWidget extends StatefulWidget {
  const MaterialAppWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

///[MyAppState] This class use to My App State
class MyAppState extends State<MaterialAppWidget> {
  OpenHelper mOpenHelper = OpenHelper();

  @override
  Widget build(BuildContext context) {
    addingMobileUiStyles(context);
    return MultiProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) =>
              CategoryBloc(openHelper: mOpenHelper),
        ),
        BlocProvider<AddCategoryBloc>(
          create: (BuildContext context) =>
              AddCategoryBloc(openHelper: mOpenHelper),
        ),
        BlocProvider<AddContactBloc>(
          create: (BuildContext context) =>
              AddContactBloc(openHelper: mOpenHelper),
        ),
        BlocProvider<ContactBloc>(
          create: (BuildContext context) =>
              ContactBloc(openHelper: mOpenHelper),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: lightThemeData(context),
        debugShowMaterialGrid: false,
        showSemanticsDebugger: false,
        showPerformanceOverlay: false,
        navigatorKey: NavigatorKey.navigatorKey,
        initialRoute: AppRoutes.routesSplash,
        home: const ScreenSplash(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

  ///[lightThemeData] This method use to ThemeData of light Theme Data
  ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light().copyWith(
        primaryColor: AppColors.colorPrimary,
        canvasColor: AppColors.colorBlack,
        cardColor: AppColors.colorGreen,
        indicatorColor: AppColors.colorRed,
        primaryColorLight: AppColors.colorYellow,
        primaryColorDark: AppColors.colorYellowDark,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
            titleSmall: AppFont.semiBoldBlack, titleMedium: AppFont.white));
  }

  /// Used by [SystemChrome] of app
  void addingMobileUiStyles(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: (Theme.of(context).brightness == Brightness.dark)
            ? Colors.transparent
            : AppColors.colorWhite,
        /* set Status bar color in Android devices. */

        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
  }
}
