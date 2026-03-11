import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:textract/core/constants/string_manager.dart';
import 'package:textract/core/config/firebase_options.dart';
import 'package:textract/core/di/service_locator.dart';
import 'package:textract/core/router/app_router.dart';
import 'package:textract/core/router/routes.dart';
import 'package:textract/core/theme/app_theme.dart';
import 'package:textract/core/theme/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  intiSetupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(getIt<FlutterSecureStorage>()),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            title: StringManager.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: Routes.splash,
          ),
        ),
      ),
    );
  }
}
