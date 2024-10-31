class ImageModel {
  late int? id;
  late String name;
  late String? url;
  late String? path;

  ImageModel({this.id, required this.name, this.url, this.path});

  factory ImageModel.fromJSON(Map<String, dynamic> json) => ImageModel(
      id: json['id'],
      name: json['image_name'],
      url: json['url'],
      path: json['path']);

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {'id': id, 'image_name': name, 'url': url, 'path': path};
    } else {
      return {'image_name': name, 'url': url, 'path': path};
    }
  }

  @override
  String toString() {
    return '''
    'id': $id,
    'image_name': $name,
    'url': $url,
    'path': $path
    ''';
  }

  void setURL(String publicUrl) {
    url = publicUrl;
  }

  void setPath(String newPath) {
    path = newPath;
  }
}
