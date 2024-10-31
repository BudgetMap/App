
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyService {


  Future<List<Map<String, dynamic>>?> getCompanies() async {
    try {
      List<Map<String, dynamic>> result =
          await Supabase.instance.client.from('company').select();
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  addCompany(Map<String, dynamic> json) async {
    try {
      await Supabase.instance.client.from('company').insert(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
