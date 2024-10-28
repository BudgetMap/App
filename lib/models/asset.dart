class Asset {
  late int? id;
  late String name;
  late int originalAmount;
  late int consumedAmount;

  Asset(
      {this.id,
      required this.name,
      required this.originalAmount,
      required this.consumedAmount});

  factory Asset.fromJSON(Map<String, dynamic> json) => Asset(
      id: json['id'],
      name: json['asset_name'],
      originalAmount: json['original_amount'],
      consumedAmount: json['consumed_amount']);

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'asset_name': name,
        'original_amount': originalAmount,
        'consumed_amount': consumedAmount
      };
    } else {
      return {
        'asset_name': name,
        'original_amount': originalAmount,
        'consumed_amount': consumedAmount
      };
    }
  }

  @override
  String toString() {
    return '''
    'id': $id,
    'asset_name': $name,
    'original_amount': $originalAmount,
    'consumed_amount': $consumedAmount
    ''';
  }
}
