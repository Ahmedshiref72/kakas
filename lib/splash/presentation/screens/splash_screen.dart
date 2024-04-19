import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kakas/shared/resources/navigation.dart';
import 'package:kakas/shared/resources/routes_manager.dart';
import '../../../shared/local/shared_preference.dart';
import '../../../shared/resources/constants_manager.dart';
import '../components/text_animation.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async{

      String? token = await CacheHelper.getData(key: AppConstants.token);
      print(token);
      print('token');
      if (token != null && token.isNotEmpty ) {
        navigateFinalTo(context: context, screenRoute: Routes.homeScreenRoute);
      }else{
        navigateFinalTo(context: context, screenRoute: Routes.loginRoute);

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedTextWidget(),
      ),
    );
  }
}
