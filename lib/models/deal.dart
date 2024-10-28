import 'dart:convert';
import 'package:budget_map/models/supplier.dart';
import 'package:intl/intl.dart';
import 'asset.dart';
import 'ordered_product.dart';

class Deal {
  late int? id;
  late int supplierID;
  late int assetID;
  late Asset? asset;
  late Supplier? supplier;
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
      required this.sideProducts,
      this.asset,
      this.supplier});

  factory Deal.fromJSON(Map<String, dynamic> json) => Deal(
      id: json['id'],
      supplierID: json['supplier_id'],
      assetID: json['asset_id'],
      date: DateFormat(dateFormat).parse(json['deal_date']),
      conversionValueUSD: (json['conversion_value_usd'] as int).toDouble(),
      mainProducts: decodeProductsList(json['main_products']),
      sideProducts: decodeProductsList(json['side_products']),
      asset: Asset.fromJSON(json['asset']),
      supplier: Supplier.fromJSON(json['supplier']));

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

  @override
  String toString() {
    return '''
    'supplier_id': $supplierID,
    'asset_id': $assetID,
    'deal_date': ${DateFormat(dateFormat).format(date)},
    'conversion_value_usd': $conversionValueUSD,
    'main_products': ${jsonEncode(mainProducts)},
    'side_products': ${jsonEncode(sideProducts)},
    'asset': ${asset.toString()},
    'supplier': ${supplier.toString()}
    ''';
  }
}
