class Supplier {
  late int? id;
  late String name;
  late String info;

  Supplier({this.id, required this.name, required this.info});

  factory Supplier.fromJSON(Map<String, dynamic> json) => Supplier(
        id: json['id'],
        name: json['name'],
        info: json['info'],
      );

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'name': name,
        'info': info,
      };
    } else {
      return {
        'name': name,
        'info': info,
      };
    }
  }
}
