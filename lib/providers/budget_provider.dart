import 'package:budget_map/models/budget.dart';
import 'package:budget_map/services/budget_service.dart';
import 'package:flutter/cupertino.dart';

class BudgetProvider with ChangeNotifier {
  late List<Budget> data;
  bool getLoading = false;
  bool getDone = false;

  bool addLoading = false;
  bool addDone = false;

  BudgetService services = BudgetService();

  getBudgets() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getBudget();

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => Budget.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void addBudget(Budget budget) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    await services.addBudget(budget.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }
}
