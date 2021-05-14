import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:algorithms_project/Controllers/cut_stick_controller.dart';
import 'package:algorithms_project/Components/input_solve.dart';

class CutStickView extends StatelessWidget {
  static const String routeName = "/cut_stick";

  @override
  Widget build(BuildContext context) {
    final Size sz = MediaQuery.of(context).size;
    final double sh = sz.height;
    final double sw = sz.width;
    final double verticalPadding = 0.03 * sh;
    final double sidePadding = 20;

    final CutStickController controller = context.read<CutStickController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Task1: Cut Stick"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: sidePadding,
        ),
        child: Column(
          children: [
            Selector<CutStickController, int>(
              selector: (_, con) => con.minCuts,
              builder: (_, minCuts, __) => Text(
                "The minimum number of cuts required to cut a stick ${controller.stickLength} units long into 1 unit pieces is\n\n${minCuts < 0 ? "" : "$minCuts"}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: verticalPadding),
            Expanded(
              child: Selector<CutStickController, List<int>>(
                  selector: (_, con) => con.stick,
                  builder: (_, stick, __) {
                    double unitLength = 0.8 * sw / controller.stickLength;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int stickPart in stick)
                          Column(
                            children: [
                              Text("$stickPart"),
                              Container(
                                height: 30,
                                width: stickPart * unitLength,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                color: Colors.purple,
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
            ),
            Selector<CutStickController, bool>(
              selector: (_, con) => con.isCuttingStick,
              builder: (_, isCuttingStick, __) {
                return InputSolve(
                  question: "How many units is the stick?",
                  textController: controller.unitsTextController,
                  solveAction:
                      isCuttingStick ? null : controller.findMinimumCuts,
                );
              },
            ),
            SizedBox(height: 2 * verticalPadding),
          ],
        ),
      ),
    );
  }
}
