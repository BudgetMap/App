import 'dart:io';
import 'dart:math';

import 'package:budget_map/models/budget.dart';
import 'package:budget_map/models/committee.dart';
import 'package:budget_map/services/budget_service.dart';
import 'package:budget_map/services/committee_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommitteeProvider with ChangeNotifier {
  late List<Committee> data;
  bool getLoading = false;
  bool getDone = false;

  bool addLoading = false;
  bool addDone = false;

  bool getBudgetsLoading = false;
  bool getBudgetsDone = false;
  late List<Budget> budgets;

  CommitteeService services = CommitteeService();
  BudgetService budgetService = BudgetService();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  addImage(Committee committee, File imageFile) async {
    String filePath =
        "image/${getRandomString(15)}.${(basename(imageFile.path).split('.') as List).last}";
    await services.uploadImage(imageFile, filePath);
    committee.setPath(filePath);
    committee.setURL(Supabase.instance.client.storage
        .from('committee-images')
        .getPublicUrl(filePath));
  }

  getCommittees() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getCommittees();

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => Committee.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void addCommittee(Committee committee, File? selectedImage) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    await addImage(committee, selectedImage!);
    await services.addCommittee(committee.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }

  getBudgets() async {
    getBudgetsLoading = true;

    List<Map<String, dynamic>>? rawBudgets = await budgetService.getBudget();

    if (rawBudgets == null) {
      getBudgetsLoading = false;
      getBudgetsDone = false;
      notifyListeners();
      return;
    }

    budgets = rawBudgets.map((json) => Budget.fromJSON(json)).toList();
    getBudgetsLoading = false;
    getBudgetsDone = true;
    notifyListeners();
  }
}
