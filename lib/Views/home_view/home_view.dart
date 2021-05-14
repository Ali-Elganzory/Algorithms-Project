import 'package:flutter/material.dart';

import 'package:algorithms_project/Views/cut_stick/cut_stick_view.dart';
import 'package:algorithms_project/Views/growing_triangles/growing_triangles_view.dart';

class HomeView extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final Size sz = MediaQuery.of(context).size;
    final double sh = sz.height;
    final double verticalPadding = 0.03 * sh;
    final double sidePadding = 20;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: sidePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CutStickView.routeName);
              },
              child: Text("Task 1: Cut Stick"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 46),
              ),
            ),
            SizedBox(height: verticalPadding),
            ElevatedButton(
              onPressed: null,
              /*() {
                Navigator.of(context).pushNamed(CutStickView.routeName);
              },*/
              child: Text("Task 2: Dynamic Programming"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 46),
              ),
            ),
            SizedBox(height: verticalPadding),
            ElevatedButton(
              onPressed: null,
              /*() {
                Navigator.of(context).pushNamed(CutStickView.routeName);
              },*/
              child: Text("Task 3: Iterative Improvement"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 46),
              ),
            ),
            SizedBox(height: verticalPadding),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(GrowingTrianglesView.routeName);
              },
              child: Text("Task 4: Grow Triangles"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 46),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
