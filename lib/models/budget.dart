class Budget {
  late int? id;
  late String name;
  late int originalAmount;
  late int consumedAmount;
  late int number;

  Budget(
      {this.id,
      required this.name,
      required this.originalAmount,
      required this.consumedAmount,
      required this.number});

  factory Budget.fromJSON(Map<String, dynamic> json) => Budget(
      id: json['id'],
      name: json['budget_name'],
      originalAmount: json['original_amount'],
      consumedAmount: json['consumed_amount'],
      number: json['budget_number']);

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'budget_name': name,
        'original_amount': originalAmount,
        'consumed_amount': consumedAmount,
        'budget_number': number
      };
    } else {
      return {
        'budget_name': name,
        'original_amount': originalAmount,
        'consumed_amount': consumedAmount,
        'budget_number': number
      };
    }
  }

  @override
  String toString() {
    return '''
    'id': $id,
    'budget_name': $name,
    'original_amount': $originalAmount,
    'consumed_amount': $consumedAmount,
    'budget_number': $number
    ''';
  }
}
