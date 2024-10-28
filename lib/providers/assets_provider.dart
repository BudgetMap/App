import 'package:budget_map/models/asset.dart';
import 'package:budget_map/services/assets_service.dart';
import 'package:flutter/cupertino.dart';

class AssetsProvider with ChangeNotifier {
  late List<Asset> data;
  bool getLoading = false;
  bool getDone = false;

  bool addLoading = false;
  bool addDone = false;

  AssetsService services = AssetsService();

  getAssets() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getAssets();

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => Asset.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void addAsset(Asset asset) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    await services.addAsset(asset.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }
}
