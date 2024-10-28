import 'dart:convert';
import 'package:intl/intl.dart';
import 'ordered_product.dart';

class Deal {
  late int? id;
  late int supplierID;
  late int assetID;
  late DateTime date;
  late double conversionValueUSD;
  late List<OrderedProduct> mainProducts;
  late List<OrderedProduct> sideProducts;

  static const String dateFormat = "yyyy-MM-dd";

  Deal(
      {this.id,
      required this.supplierID,
      required this.assetID,
      required this.date,
      required this.conversionValueUSD,
      required this.mainProducts,
      required this.sideProducts});

  factory Deal.fromJSON(Map<String, dynamic> json) => Deal(
      id: json['id'],
      supplierID: json['supplier_id'],
      assetID: json['asset_id'],
      date: DateFormat(dateFormat).parse(json['deal_date']),
      conversionValueUSD: (json['conversion_value_usd'] as int).toDouble(),
      mainProducts: decodeProductsList(json['main_products']),
      sideProducts: decodeProductsList(json['side_products']));

  static List<OrderedProduct> decodeProductsList(String json) =>
      (jsonDecode(json) as List)
          .map((i) => OrderedProduct.fromJson(i))
          .toList();

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'supplier_id': supplierID,
        'asset_id': assetID,
        'deal_date': DateFormat(dateFormat).format(date),
        'conversion_value_usd': conversionValueUSD,
        'main_products': jsonEncode(mainProducts),
        'side_products': jsonEncode(sideProducts),
      };
    } else {
      return {
        'supplier_id': supplierID,
        'asset_id': assetID,
        'deal_date': DateFormat(dateFormat).format(date),
        'conversion_value_usd': conversionValueUSD,
        'main_products': jsonEncode(mainProducts),
        'side_products': jsonEncode(sideProducts),
      };
    }
  }
}
