import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api/pages/splash_screen.dart';
import 'package:provider/provider.dart';

import 'Helper/providers.dart';
import 'Helper/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430.0, 932.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: providers,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GitHub API',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: routes,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
