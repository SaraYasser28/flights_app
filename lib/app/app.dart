import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/providers/app_providers.dart';
import '../core/routing/app_router.dart';
import '../core/routing/app_routes.dart';
import '../core/theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProviders = AppProviders();

    return MultiBlocProvider(
      providers: appProviders.providers,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.signIn,
            onGenerateRoute: AppRouter.generateRoute,
            title: 'Skiee',
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Inter',
              scaffoldBackgroundColor: AppColors.lightGreyBackground,
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            ),
          );
        },
      ),
    );
  }
}
