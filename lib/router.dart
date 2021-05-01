import 'package:flutter/material.dart';

import 'package:algorithms_project/Views/home_view/home_view.dart';
import 'package:algorithms_project/Views/cut_stick/cut_stick_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.routeName:
        return SlideRoute(page: HomeView(), direction: SlideDirection.right);

      case CutStickView.routeName:
        return SlideRoute(
            page: CutStickView(), direction: SlideDirection.right);

      default:
        return MaterialPageRoute(builder: (_) => HomeView());
    }
  }
}

enum SlideDirection { left, right, up, down }

class SlideRoute extends PageRouteBuilder {
  final SlideDirection direction;
  final Widget page;

  SlideRoute({
    required this.page,
    this.direction = SlideDirection.left,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: direction == SlideDirection.left
                  ? Offset(1, 0)
                  : direction == SlideDirection.right
                      ? Offset(-1, 0)
                      : direction == SlideDirection.up
                          ? Offset(0, 1)
                          : Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
}
