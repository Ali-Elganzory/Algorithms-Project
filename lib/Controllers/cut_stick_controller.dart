import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CutStickController with ChangeNotifier {
  TextEditingController _unitsController = TextEditingController();
  TextEditingController get unitsController => _unitsController;

  int _minCuts = -1;
  int get minCuts => _minCuts;
  set minCuts(int v) {
    _minCuts = v;
    notifyListeners();
  }

  int findMinimumCuts() {
    int input = int.tryParse(_unitsController.text) ?? 1;
    minCuts = (log(input) / log(2)).ceil();
    return minCuts;
  }

  void dispose() {
    super.dispose();
    _unitsController.dispose();
  }
}
