import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetService {
  Future<List<Map<String, dynamic>>?> getBudget() async {
    try {
      List<Map<String, dynamic>> result =
          await Supabase.instance.client.from('budget').select();
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  addBudget(Map<String, dynamic> json) async {
    try {
      await Supabase.instance.client.from('budget').insert(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
