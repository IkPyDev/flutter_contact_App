import 'dart:async';

import 'package:contact_app_gita/bloc/home/home_bloc.dart';
import 'package:contact_app_gita/bloc/login/login_bloc.dart';
import 'package:contact_app_gita/data/db_manager.dart';
import 'package:contact_app_gita/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      DbManager().isLoggedIn().then((value) {
        if (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (BuildContext context) => HomeBloc()..add(LoadContacts()),
                child: const Home(),
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (BuildContext context) => LoginBloc(),
                child: const Login(),
              ),
            ),
          );
        }
      });
    });
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
            child: Center(child: Image.asset("assets/splash.png")),
          ),
          Expanded(
            flex: 1,
            child: Center(child: Image.asset("assets/ui/loading.png")),
          ),

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
