import 'package:budget_map/models/company.dart';
import 'package:budget_map/services/company_service.dart';
import 'package:flutter/cupertino.dart';

class CompanyProvider with ChangeNotifier {
  late List<Company> data;
  bool getLoading = false;
  bool getDone = false;

  bool addLoading = false;
  bool addDone = false;

  CompanyService services = CompanyService();

  getCompanies() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getCompanies();

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => Company.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void addCompany(Company company) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    await services.addCompany(company.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }
}
