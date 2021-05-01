import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:algorithms_project/Controllers/cut_stick_controller.dart';

class CutStickView extends StatelessWidget {
  static const String routeName = "/cut_stick";

  @override
  Widget build(BuildContext context) {
    final Size sz = MediaQuery.of(context).size;
    final double sh = sz.height;
    final double verticalPadding = 0.03 * sh;
    final double sidePadding = 20;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "The minimum number of cuts required if you have a stick n unit long needs to be cut into n unit pieces.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: verticalPadding),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "How many units is the stick?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  child: TextField(
                    controller:
                        context.read<CutStickController>().unitsController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r"^0$"))
                    ],
                    decoration: InputDecoration(
                      hintText: "n units",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: verticalPadding),
            TextButton(
              onPressed: () {
                context.read<CutStickController>().findMinimumCuts();
              },
              child: Text(
                "Solve",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: verticalPadding),
            Selector<CutStickController, int>(
              selector: (_, con) => con.minCuts,
              builder: (_, minCuts, __) => Text(
                minCuts < 0 ? "" : "$minCuts",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
