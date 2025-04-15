import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/basic_features.dart';
import '../core/theme/app_theme_data.dart';
import 'bottom_nav/bottom_nav.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    setState(() {
      this.brightness = brightness;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness));
    });
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, widget) => GestureDetector(
          onTap: AppUtils.closeKeyboard,
          child: GetMaterialApp(
            builder: EasyLoading.init(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: ScrollConfiguration(
                    behavior: AppScrollPhysics(), child: child!),
              ),
            ),
            theme: AppThemeData.lightTheme,
            defaultTransition: Transition.cupertino,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            title: AppString.appName,
            home: const BottomNav(),
          ),
        ),
      );
}

class AppScrollPhysics extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(); // Replace with your desired ScrollPhysics
  }

  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Removes overscroll glow effect
  }
}
