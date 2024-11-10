class ShoeModel {
  final int id;
  final String name;
  final String brand;
  final String model;
  final String comment;
  final String ownerFullName;
  final String phoneNumber;
  final String imagePath;


  ShoeModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.comment,
    required this.ownerFullName,
    required this.phoneNumber,
    required this.imagePath,
  });

  factory ShoeModel.fromMap(Map<String, dynamic> map) {
    return ShoeModel(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      model: map['model'],
      comment: map['comment'],
      ownerFullName: map['ownerFullName'],
      phoneNumber: map['phoneNumber'],
      imagePath: map['imagePath']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'comment': comment,
      'ownerFullName': ownerFullName,
      'phoneNumber': phoneNumber,
      'imagePath' : imagePath
    };
  }
}
