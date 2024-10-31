class Company {
  late int? id;
  late String name;
  late String info;

  Company({this.id, required this.name, required this.info});

  factory Company.fromJSON(Map<String, dynamic> json) => Company(
        id: json['id'],
        name: json['company_name'],
        info: json['info'],
      );

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'company_name': name,
        'info': info,
      };
    } else {
      return {
        'company_name': name,
        'info': info,
      };
    }
  }

  @override
  String toString() {
    return '''
      'id': $id,
      'company_name': $name,
      'info': $info,
    ''';
  }
}
