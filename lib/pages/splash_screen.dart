import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulHookWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 3),
    );
    Animation animation2 = Tween<double>(begin: 0.3, end: 1)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    useEffect(() {
      animationController.forward();
      return null;
    }, const []);
    useAnimation(animationController);

    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: animation2.value,
          child: Image.asset(
            'assets/images/GitHub-logo.png',
            width: 200.w,
          ),
        ),
      ),
    );
  }
}
