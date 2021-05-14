import 'dart:math';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:stack_canvas/stack_canvas.dart';

class GrowingTrianglesController extends ChangeNotifier {
  final TextEditingController _iterationsTextController =
      TextEditingController();
  TextEditingController get iterationsTextController =>
      _iterationsTextController;

  int get iterations => int.tryParse(_iterationsTextController.text) ?? 1;

  final StackCanvasController _canvasController = StackCanvasController(
    offsetReference: Reference.Center,
    zoomReference: Reference.Center,
  );
  StackCanvasController get canvasController => _canvasController;

  static const double _triangleSide = 120;
  static const double _triangleHeight = _triangleSide / 2 * 1.731;
  static const int _animationDelay = 400;

  final _randomGenerator = Random();
  final List<Color> colors = [
    Colors.redAccent,
    Colors.lightBlue,
    Colors.purple,
    Colors.amber,
    Colors.green,
    Colors.teal,
    Colors.orange,
  ];

  Color get randomColor => colors[_randomGenerator.nextInt(colors.length)];

  void solve() {
    if (areTrianglesGrowing) return;
    growTriangles(iterations);
  }

  bool _areTrianglesGrowing = false;
  bool get areTrianglesGrowing => _areTrianglesGrowing;
  set areTrianglesGrowing(bool v) {
    _areTrianglesGrowing = v;
    notifyListeners();
  }

  Future<void> growTriangles(int iterations) async {
    // Reserve the state
    areTrianglesGrowing = true;

    // Initializing algorithm
    canvasController.clearCanvas();
    canvasController.resetCanvasTransformation();
    canvasController.offset = Offset(-_triangleSide / 2, -_triangleHeight / 2);
    HashSet<Point<int>> grownSet = HashSet<Point<int>>();
    Queue<Point<int>> queue = Queue<Point<int>>();
    Point<int> point = Point<int>(0, 0);
    Color color = randomColor;
    grownSet.add(point);
    queue.add(point);
    canvasController.addCanvasObjects([
      triangleCanvasObject(
        point: queue.first,
        side: _triangleSide,
        height: _triangleHeight,
        color: color,
      ),
    ]);
    final int it = iterations;
    int itCount = 1;
    while (++itCount <= it) {
      canvasController.scale = (canvasController.canvasSize.shortestSide - 60) /
          (itCount * _triangleHeight);
      await Future.delayed(Duration(milliseconds: _animationDelay));
      color = randomColor;
      for (int i = queue.length; i > 0; i--) {
        point = queue.removeFirst();
        List<Point<int>> points = [
          point + Point(-1, 0),
          point + Point(1, 0),
          point + Point(0, isTriangleDownward(point) ? -1 : 1),
        ].where((e) => !grownSet.contains(e)).toList();

        final List<CanvasObject<Widget>> objects = points
            .map((e) => triangleCanvasObject(
                  point: e,
                  side: _triangleSide,
                  height: _triangleHeight,
                  color: color,
                ))
            .toList();

        grownSet.addAll(points);
        queue.addAll(points);
        canvasController.addCanvasObjects(objects);
      }
    }

    // Release the state
    areTrianglesGrowing = false;
  }

  bool isTriangleDownward(Point<int> p) => (p.x + p.y) % 2 == 0;

  CanvasObject<Widget> triangleCanvasObject({
    required Point<int> point,
    required double side,
    required double height,
    Color color = Colors.black,
  }) {
    return CanvasObject<Widget>(
      dx: side / 2 * point.x,
      dy: height * point.y,
      width: side,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/white_${isTriangleDownward(point) ? "downward" : "upward"}_triangle.png"),
            colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
          ),
        ),
      ),
    );
  }
}
