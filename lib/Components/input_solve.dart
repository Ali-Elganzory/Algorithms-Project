import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void ActionType();

class InputSolve extends StatelessWidget {
  const InputSolve({
    this.width = 400,
    required this.question,
    required this.textController,
    required this.solveAction,
  });

  final double width;
  final String question;
  final TextEditingController textController;
  final ActionType? solveAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: TextField(
                  controller: textController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r"^0$"))
                  ],
                  decoration: InputDecoration(
                    hintText: "Write here",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: solveAction,
            child: Text("Solve"),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.maxFinite, 40),
            ),
          ),
        ],
      ),
    );
  }
}
