import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CutStickController with ChangeNotifier {
  TextEditingController _unitsController = TextEditingController();
  TextEditingController get unitsController => _unitsController;

  // State
  int _stickLength = 1;
  int _minCuts = 0;
  List<int> _stick = [1];

  // Getters & Seeters
  int get stickLength => _stickLength;
  set stickLength(int v) {
    _stickLength = v;
    notifyListeners();
  }

  int get minCuts => _minCuts;
  set minCuts(int v) {
    _minCuts = v;
    notifyListeners();
  }

  List<int> get stick => _stick;
  set stick(List<int> v) {
    _stick = v;
    notifyListeners();
  }

  // Greedy solution for the minimum cuts
  int findMinimumCuts() {
    {
      // Extract user input as an [int]
      stickLength = int.tryParse(_unitsController.text) ?? 1;
      // Calculate minimum number of cuts
      minCuts = (log(stickLength) / log(2)).ceil();
    }

    // For simulation purposes
    findMinimumCutsSimulated();
    return minCuts;
  }

  Future<void> findMinimumCutsSimulated() async {
    stick = [stickLength];
    for (int i = minCuts; i > 0; i--) {
      await Future.delayed(Duration(milliseconds: 500));
      stick = stick
          .expand<int>((stickPart) => stickPart < 2
              ? [stickPart]
              : [stickPart ~/ 2 + stickPart % 2, stickPart ~/ 2])
          .toList();
    }
  }

  void dispose() {
    super.dispose();
    _unitsController.dispose();
  }
}
