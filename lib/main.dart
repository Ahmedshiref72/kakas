import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'shared/bloc_observer.dart';
import 'shared/local/shared_preference.dart';
import 'shared/network/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();



  runApp(DevicePreview(enabled: !kReleaseMode,
      builder: (context) => const MyApp()));
}