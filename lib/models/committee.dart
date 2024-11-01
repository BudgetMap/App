import 'dart:convert';
import 'package:intl/intl.dart';
import 'budget.dart';
import 'ordered_product.dart';

class Committee {
  late int? id;
  late int number;
  late int budgetID;
  late Budget? budget;
  late DateTime date;
  late double exchangeRateUSD;
  late String? imageURL;
  late String? imagePath;
  late int? total;

  static const String dateFormat = "yyyy-MM-dd";

  Committee(
      {this.id,
      required this.number,
      required this.budgetID,
      required this.date,
      required this.exchangeRateUSD,
      this.imageURL,
      this.imagePath,
      this.budget,
      this.total});

  factory Committee.fromJSON(Map<String, dynamic> json) => Committee(
      id: json['id'],
      number: json['committee_number'],
      budgetID: json['budget_id'],
      date: DateFormat(dateFormat).parse(json['committee_date']),
      exchangeRateUSD: (json['usd_exchange_rate'] as int).toDouble(),
      imageURL: json['committee_image_url'],
      imagePath: json['committee_image_path'],
      total: json['sum'],
      budget: Budget.fromJSON(json['budget']));

  static List<OrderedProduct> decodeProductsList(String json) =>
      (jsonDecode(json) as List)
          .map((i) => OrderedProduct.fromJson(i))
          .toList();

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'committee_number': number,
        'budget_id': budgetID,
        'committee_date': DateFormat(dateFormat).format(date),
        'usd_exchange_rate': exchangeRateUSD,
        'committee_image_url': imageURL,
        'committee_image_path': imagePath,
      };
    } else {
      return {
        'committee_number': number,
        'budget_id': budgetID,
        'committee_date': DateFormat(dateFormat).format(date),
        'usd_exchange_rate': exchangeRateUSD,
        'committee_image_url': imageURL,
        'committee_image_path': imagePath,
      };
    }
  }

  @override
  String toString() {
    return '''
    'id': $id,
    'committee_number': $number,
    'budget_id': $budgetID,
    'committee_date': ${DateFormat(dateFormat).format(date)},
    'usd_exchange_rate': $exchangeRateUSD,
    'committee_image_url': $imageURL,
    'committee_image_path': $imagePath,
    'sum': $total,
    ''';
  }

  void setURL(String publicUrl) {
    imageURL = publicUrl;
  }

  void setPath(String newPath) {
    imagePath = newPath;
  }
}
