import 'dart:convert';

import 'package:budget_map/models/ordered_product.dart';

class Deal {
  late int? id;
  late int committeeID;
  late int companyID;
  late List<OrderedProduct> mainProducts;
  late List<OrderedProduct>? sideProducts;
  late int paidAmount;
  late String? notes;

  Deal(
      {this.id,
      required this.committeeID,
      required this.companyID,
      required this.mainProducts,
      this.sideProducts,
      required this.paidAmount,
      this.notes});

  factory Deal.fromJSON(Map<String, dynamic> json) => Deal(
      id: json['id'],
      committeeID: json['committee_id'],
      companyID: json['company_id'],
      mainProducts: decodeProductsList(json['main_products']),
      sideProducts: decodeProductsList(json['side_products']),
      paidAmount: json['paid_amount']);

  static List<OrderedProduct> decodeProductsList(String json) =>
      (jsonDecode(json) as List)
          .map((i) => OrderedProduct.fromJson(i))
          .toList();

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'committee_id': committeeID,
        'company_id': companyID,
        'main_products': jsonEncode(mainProducts),
        'side_products': jsonEncode(sideProducts),
        'paid_amount': paidAmount,
        'notes': notes ?? ""
      };
    } else {
      return {
        'committee_id': committeeID,
        'company_id': companyID,
        'main_products': jsonEncode(mainProducts),
        'side_products': jsonEncode(sideProducts),
        'paid_amount': paidAmount,
        'notes': notes ?? "",
      };
    }
  }

  @override
  String toString() {
    return '''
    'id': $id,
    'committee_id': $committeeID,
    'company_id': $companyID,
    'main_products': $mainProducts,
    'side_products':$sideProducts ,
    'paid_amount': $paidAmount,
    'notes': $notes 
    ''';
  }
}
