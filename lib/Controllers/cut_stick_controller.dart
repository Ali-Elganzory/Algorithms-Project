import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CutStickController with ChangeNotifier {
  TextEditingController _unitsTextController = TextEditingController();
  TextEditingController get unitsTextController => _unitsTextController;

  // State
  int _minCuts = 0;
  List<int> _stick = [1];

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

  bool _isCuttingStick = false;
  bool get isCuttingStick => _isCuttingStick;
  set isCuttingStick(bool v) {
    _isCuttingStick = v;
    notifyListeners();
  }

  int get stickLength => int.tryParse(_unitsTextController.text) ?? 1;

  // Greedy solution for the minimum cuts
  int findMinimumCuts() {
    // Calculate minimum number of cuts
    minCuts = (log(stickLength) / log(2)).ceil();

    // For simulation purposes
    findMinimumCutsSimulated();
    return minCuts;
  }

  Future<void> findMinimumCutsSimulated() async {
    isCuttingStick = true;

    stick = [stickLength];
    for (int i = minCuts; i > 0; i--) {
      await Future.delayed(Duration(milliseconds: 500));
      stick = stick
          .expand<int>((stickPart) => stickPart < 2
              ? [stickPart]
              : [stickPart ~/ 2 + stickPart % 2, stickPart ~/ 2])
          .toList();
    }

    isCuttingStick = false;
  }

  void dispose() {
    super.dispose();
    _unitsTextController.dispose();
  }
}
