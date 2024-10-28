import 'dart:convert';

import 'package:budget_map/models/ordered_product.dart';

class Status {
  late int? id;
  late int dealID;
  late int paidAmount;
  late List<OrderedProduct> deliveredProducts;
  late String? notes;

  Status(
      {this.id,
      required this.dealID,
      required this.paidAmount,
      required this.deliveredProducts,
      required this.notes});

  static List<OrderedProduct> decodeProductsList(Map<String, dynamic> json) =>
      (jsonDecode(json['main_products']) as List)
          .map((i) => OrderedProduct.fromJson(i))
          .toList();

  factory Status.fromJSON(Map<String, dynamic> json) => Status(
      id: json['id'],
      dealID: json['deal_id'],
      paidAmount: json['paid_amount'],
      deliveredProducts: decodeProductsList(json['delivered_products']),
      notes: json['notes']);

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'deal_id': dealID,
        'paid_amount': paidAmount,
        'delivered_products': jsonEncode(deliveredProducts),
        'notes': notes
      };
    } else {
      return {
        'deal_id': dealID,
        'paid_amount': paidAmount,
        'delivered_products': jsonEncode(deliveredProducts),
        'notes': notes
      };
    }
  }
}
