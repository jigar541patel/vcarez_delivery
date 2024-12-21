import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import '../../storage/shared_pref_const.dart';
import '../../utils/images_utils.dart';
import '../../utils/route_names.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc splashBloc = SplashBloc();
  var storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    startTime();
  }

  startTime() async {
    String? token = await storage.read(key: keyUserToken);
    debugPrint("vcarez customer reading access token have is $token");
    if (token == null) {
      var duration = const Duration(seconds: 5);
      Timer(duration, getNavigationPage);
    } else {
      splashBloc.add(GetProfileEvent());
      // if (!mounted) return;
      // Navigator.pushReplacementNamed(context, routeDashboard);
    }
  }

  getNavigationPage() async {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, routeLogin);
  }

  @override
  Widget build(BuildContext context) {
    //Widget imageAppLogo() => Image.asset(appLogo,);

    Widget imageAppLogo() => SvgPicture.asset(
          appLogo_,
          fit: BoxFit.none,
        );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider(
          create: (context) => splashBloc,
          child: Center(
            child: BlocConsumer<SplashBloc, SplashState>(
              listener: (context, state) async {
                // TODO: implement listener
                if (state is TokenExpired) {
                   await storage.deleteAll();
                  Navigator.pushReplacementNamed(context, routeLogin);
                } else if (state is DataLoaded) {
                  Navigator.pushReplacementNamed(context, routeDashboard);
                }
              },
              builder: (context, state) {
                return imageAppLogo();
              },
            ),
          ),
        ),
      ),
    );
  }
}
