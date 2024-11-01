import 'package:budget_map/models/budget.dart';
import 'package:budget_map/models/company.dart';
import 'package:budget_map/services/budget_service.dart';
import 'package:budget_map/services/company_service.dart';
import 'package:budget_map/services/deal_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/deal.dart';

class DealProvider with ChangeNotifier {
  late List<Deal> data;
  bool getLoading = false;
  bool getDone = false;

  bool getCompaniesLoading = false;
  bool getCompaniesDone = false;
  late List<Company> companies;

  CompanyService companyService = CompanyService();

  bool addLoading = false;
  bool addDone = false;

  DealService services = DealService();

  getDeals({required int committeeID}) async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData =
        await services.getDeals(committeeID: committeeID);

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => Deal.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void addDeal(Deal deal) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    await services.addDeal(deal.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }

  getCompanies() async {
    getCompaniesLoading = true;

    List<Map<String, dynamic>>? rawBudgets =
        await companyService.getCompanies();

    if (rawBudgets == null) {
      getCompaniesLoading = false;
      getCompaniesDone = false;
      notifyListeners();
      return;
    }

    companies = rawBudgets.map((json) => Company.fromJSON(json)).toList();
    getCompaniesLoading = false;
    getCompaniesDone = true;
    notifyListeners();
  }
}
