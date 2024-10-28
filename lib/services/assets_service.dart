import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AssetsService {
  Future<List<Map<String, dynamic>>?> getAssets() async {
    try {
      List<Map<String, dynamic>> result =
          await Supabase.instance.client.from('asset').select();
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  addAsset(Map<String, dynamic> json) async {
    try {
      await Supabase.instance.client.from('asset').insert(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
