import 'package:budget_map/models/asset.dart';
import 'package:budget_map/models/deal.dart';
import 'package:budget_map/services/assets_service.dart';
import 'package:budget_map/services/deals_service.dart';
import 'package:budget_map/services/suppliers_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/supplier.dart';

class DealsProvider with ChangeNotifier {
  late List<Deal> data;
  bool getLoading = false;
  bool getDone = false;

  bool addLoading = false;
  bool addDone = false;

  bool getAssetsAndSuppliersLoading = false;
  bool getAssetsAndSuppliersDone = false;
  late List<Asset> assets;
  late List<Supplier> suppliers;

  DealsService services = DealsService();
  AssetsService assetsService = AssetsService();
  SuppliersService suppliersService = SuppliersService();

  getDeals() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getDeals();

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

  getAssetsAndSuppliers() async {
    getAssetsAndSuppliersLoading = true;

    List<Map<String, dynamic>>? rawAssets = await assetsService.getAssets();
    List<Map<String, dynamic>>? rawSuppliers =
        await suppliersService.getSuppliers();

    if (rawAssets == null || rawSuppliers == null) {
      getAssetsAndSuppliersLoading = false;
      getAssetsAndSuppliersDone = false;
      notifyListeners();
      return;
    }

    assets = rawAssets.map((json) => Asset.fromJSON(json)).toList();
    suppliers = rawSuppliers.map((json) => Supplier.fromJSON(json)).toList();
    getAssetsAndSuppliersLoading = false;
    getAssetsAndSuppliersDone = true;
    notifyListeners();
  }
}
