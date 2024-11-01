class OrderedProduct {
  late String name;
  late int amount;
  late int oldPrice;
  late int newPrice;
  late bool delivered;

  OrderedProduct(
      {required this.name,
      required this.amount,
      required this.oldPrice,
      required this.newPrice,
      required this.delivered});

  Map toJson() => {
        'name': name,
        'amount': amount,
        'old_price': oldPrice,
        'new_price': newPrice,
        'delivered': delivered
      };

  factory OrderedProduct.fromJson(Map<String, dynamic> json) => OrderedProduct(
      name: json['name'] as String,
      amount: json['amount'] as int,
      oldPrice: json['old_price'] as int,
      newPrice: json['new_price'] as int,
      delivered: json['delivered'] as bool);

  @override
  String toString() => '''
      'name': $name,
      'amount': $amount,
      'old_price': $oldPrice,
      'new_price': $newPrice,
      'delivered': $delivered
      ''';
}
