import 'package:silver_touch_task/modules/core/utils/common_import.dart';

/// This class is a stateful widget that creates a state object that is used to create a splash screen
/// `ScreenSplash` is a `StatefulWidget` that creates a `_ScreenSplashState` when it's built
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      NavigatorKey.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          AppRoutes.routesScreenDashboard, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget background = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.margin40),
      height: MediaQuery.of(context).size.width - Dimens.margin40,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        APPImages.icLogoWithText,
        fit: BoxFit.cover,
      ),
    );
    return SafeArea(
        child: Scaffold(
      body: Center(child: background),
    ));
  }
}
