/*
*╔══════════════════════════════════════════════════════════════════════╗
*║                         Skiee Flight App UI                          ║
*╠══════════════════════════════════════════════════════════════════════╣
*║ Author      : Sara Yasser Ahmed                                      ║
*║ Date        : 8/3/2026                                               ║
*║ File        : main.dart                                              ║
*╠══════════════════════════════════════════════════════════════════════╣
*║ This file initializes the Flutter application and configures         ║
*║ the global settings including:                                       ║
*║                                                                      ║
*║ • Application theme and color scheme                                 ║
*║ • Initial route and navigation system (AppRouter)                    ║
*║ • Base application configuration                                     ║
*║                                                                      ║
*║ The project demonstrates a modern flight booking interface built     ║
*║ with Flutter using a feature-based architecture and reusable UI      ║
*║ components for scalability and maintainability.                      ║
*╠══════════════════════════════════════════════════════════════════════╣
*║ Notes                                                                ║
*║ • This project currently focuses on UI implementation only.          ║
*║ • No backend or API integration is included in this phase.           ║
*║ • Mock data is used to demonstrate UI components and flows.          ║
*║                                                                      ║
*║ For full documentation, setup instructions, and project structure,   ║
*║ please refer to the ║README.md║ file in the repository.              ║
*╚══════════════════════════════════════════════════════════════════════╝
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // frame size
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
    );
  }
}
