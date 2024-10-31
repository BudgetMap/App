import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommitteeService {
  uploadImage(File imageFile, String filePath) async {
    try {
      final response = await Supabase.instance.client.storage
          .from('committee-images') // Replace with your storage bucket name
          .upload(filePath, imageFile);
      if (kDebugMode) {
        print('Response: $response');
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<Map<String, dynamic>>?> getCommittees() async {
    try {
      List<Map<String, dynamic>> result =
          await Supabase.instance.client.from('committee').select("*, budget(*)");
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  addCommittee(Map<String, dynamic> json) async {
    try {
      await Supabase.instance.client.from('committee').insert(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
