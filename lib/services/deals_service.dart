import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DealsService {
  Future<List<Map<String, dynamic>>?> getDeals() async {
    try {
      List<Map<String, dynamic>> result =
          await Supabase.instance.client.from('deal').select("*, asset(*), supplier(*)");
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  addDeal(Map<String, dynamic> json) async {
    try {
      await Supabase.instance.client.from('deal').insert(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
