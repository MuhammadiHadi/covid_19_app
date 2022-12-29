import 'dart:async';

import 'package:covid_19_app/screen/home_view.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeView())));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Container(
                  child: Center(child: Image.asset("assets/images/virus.png")),
                ),
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: 80,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Covid_19\nTracker App",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
