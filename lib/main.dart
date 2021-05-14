import 'package:flutter/material.dart';

import 'router.dart' as router;

import 'package:algorithms_project/Views/home_view/home_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Visual Algorithms",
      home: HomeView(),
      onGenerateRoute: router.Router.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
            bodyText1: TextStyle(
          fontSize: 16,
        )),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1),
          ),
          contentPadding: const EdgeInsets.all(12),
          isDense: true,
        ),
      ),
    );
  }
}
