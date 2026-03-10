class UpdateModel {
  final String? name;
  final String? image;
  const UpdateModel({this.name, this.image});

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image};
  }
}
