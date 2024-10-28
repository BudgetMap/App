import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SuppliersService {
  Future<List<Map<String, dynamic>>?> getSuppliers() async {
    try {
      List<Map<String, dynamic>> result =
          await Supabase.instance.client.from('supplier').select();
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  addSupplier(Map<String, dynamic> json) async {
    try {
      await Supabase.instance.client.from('supplier').insert(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
