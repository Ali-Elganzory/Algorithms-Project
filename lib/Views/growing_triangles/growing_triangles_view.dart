import 'package:algorithms_project/Components/input_solve.dart';
import 'package:algorithms_project/Controllers/growing_triangles_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stack_canvas/stack_canvas.dart';

class GrowingTrianglesView extends StatelessWidget {
  static const String routeName = "/growing-triangles";
  static const String title = "Growing Triangles";

  @override
  Widget build(BuildContext context) {
    final GrowingTrianglesController controller =
        context.read<GrowingTrianglesController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: StackCanvas(
              canvasController: controller.canvasController,
            ),
          ),
          Selector<GrowingTrianglesController, bool>(
            selector: (_, con) => con.areTrianglesGrowing,
            builder: (_, areTrianglesGrowing, __) {
              return InputSolve(
                question: "How many iterations of growing?",
                textController: context
                    .read<GrowingTrianglesController>()
                    .iterationsTextController,
                solveAction: areTrianglesGrowing ? null : controller.solve,
              );
            },
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
