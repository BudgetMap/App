import 'dart:io';
import 'dart:math';

import 'package:budget_map/models/image.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart';

import '../services/images_service.dart';


class ImagesProvider with ChangeNotifier {
  late List<ImageModel> data;
  bool addLoading = false;
  bool addDone = false;

  bool getLoading = false;
  bool getDone = false;

  ImagesService services = ImagesService();

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  void addImage(ImageModel image, File imageFile) async {
    addLoading = true;
    addDone = false;
    notifyListeners();

    String filePath =
        "image/${getRandomString(15)}.${(basename(imageFile.path).split('.') as List).last}";
    await services.uploadImage(imageFile, filePath);
    image.setPath(filePath);
    image.setURL(Supabase.instance.client.storage
        .from('committee-images')
        .getPublicUrl(filePath));
    await services.addImage(image.toJson());

    addLoading = false;
    addDone = true;
    notifyListeners();
  }

  void getImages() async {
    getLoading = true;

    List<Map<String, dynamic>>? rawData = await services.getImages();

    if (rawData == null) {
      getLoading = false;
      getDone = false;
      notifyListeners();
      return;
    }

    data = rawData.map((json) => ImageModel.fromJSON(json)).toList();
    getLoading = false;
    getDone = true;
    notifyListeners();
  }

  void test() {
    if (kDebugMode) {
      print("test");
    }
  }
}
