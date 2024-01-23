import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locator.dart';
import 'ui/route_navigation.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  setupLocator();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String? isSignedIn = preferences.getString('access_token');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Exam 1',
    initialRoute:
        isSignedIn != null ? RouteNavigation.signIn : RouteNavigation.listview,
    onGenerateRoute: RouteNavigation.generateRoute,
  ));
}

// import 'package:flutter/material.dart';
//
// import 'locator.dart';
// import 'ui/route_navigation.dart';
//
// late String? isSignedIn;
// void main() async {
//   setupLocator();
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Exam 2',
//       initialRoute: RouteNavigation.signIn,
//       onGenerateRoute: RouteNavigation.generateRoute,
//     );
//   }
// }
