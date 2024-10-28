class OrderedProduct {
  late String name;
  late int amount;
  late int priceInUSD;

  OrderedProduct(
      {required this.name, required this.amount, required this.priceInUSD});

  Map toJson() => {'name': name, 'amount': amount, 'price_in_usd': priceInUSD};

  factory OrderedProduct.fromJson(Map<String, dynamic> json) => OrderedProduct(
      name: json['name'] as String,
      amount: json['amount'] as int,
      priceInUSD: json['price_in_usd'] as int);

  @override
  String toString() =>
      "{'name': $name, 'amount': $amount, 'price_in_usd': $priceInUSD}";
}

// void main() {
//   List<OrderedProduct> mainProducts = [
//     OrderedProduct(name: 'laptop', amount: 1, priceInUSD: 10),
//     OrderedProduct(name: 'pc', amount: 2, priceInUSD: 20)
//   ];
//
//   print(jsonEncode(mainProducts));
//   List<OrderedProduct> decoded = (jsonDecode(jsonEncode(mainProducts)) as List)
//       .map((i) => OrderedProduct.fromJson(i))
//       .toList();
//   print(decoded);
// }
