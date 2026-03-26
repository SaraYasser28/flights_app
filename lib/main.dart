/*
*╔══════════════════════════════════════════════════════════════════════╗
*║                         Skiee Flight App                             ║
*╠══════════════════════════════════════════════════════════════════════╣
*║ Author   : Sara Yasser Ahmed                                         ║
*║ Date     : 26/3/2026                                                 ║
*╠══════════════════════════════════════════════════════════════════════╣
*║ A functional flight booking app built with Clean Architecture        ║
*║ and MVVM pattern. Complete user journey from auth to booking.        ║
*║                                                                      ║
*║  Core Features:                                                      ║
*║   • Full Auth System (Sign up/in with validation)                    ║
*║   • Persistent Favorites (in-memory)                                 ║
*║   • Flight Booking (passenger selection, price calculation)          ║
*║   • Advanced Search (real-time, filters, sorting)                    ║
*║   • Booking History (upcoming/past tabs)                             ║
*║   • User Profile                                                     ║
*╠══════════════════════════════════════════════════════════════════════╣                                                                     ║
*║ For complete documentation, setup instructions, and detailed         ║
*║    project structure, please refer to the README.md file.            ║
*╚══════════════════════════════════════════════════════════════════════╝
*/

import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
