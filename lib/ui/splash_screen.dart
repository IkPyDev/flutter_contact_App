import 'dart:async';

import 'package:contact_app_gita/ui/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Login())));
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child:Center(child: Image.asset("assets/splash.png")), ),
          Expanded(
            flex: 1,
            child:Center(child: Image.asset("assets/ui/loading.png")), ),


          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: RotationTransition(
          //       turns: _controller, child: Image.network('https://loading.io/assets/mod/spinner/spinner/lg.gif')),
          // ),
        ],
      ),
    );
  }
}
