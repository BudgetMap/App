import 'package:budget_map/models/supplier.dart';
import 'package:budget_map/services/suppliers_service.dart';
import 'package:flutter/cupertino.dart';

class SuppliersProvider with ChangeNotifier {
  late List<Supplier> data;
  bool getLoading = false;
  bool getDone = false;

  bool addLoading = false;
  bool addDone = false;

  SuppliersService services = SuppliersService();

  getSuppliers() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getSuppliers();

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => Supplier.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void addSupplier(Supplier supplier) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    await services.addSupplier(supplier.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }
}
