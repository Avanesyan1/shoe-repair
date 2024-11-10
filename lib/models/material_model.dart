class MaterialModel {
  final int id;
  final String name;
  final String description;
  final int count;
  final String imagePath;

  MaterialModel({
    required this.id,
    required this.name,
    required this.description,
    required this.count,
    required this.imagePath,
  });

  factory MaterialModel.fromMap(Map<String, dynamic> map){
    return MaterialModel(
      id : map['id'],
      name : map['name'],
      description : map['description'],
      count : map['count'],
      imagePath : map['imagePath']
    );
  }
      

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'count': count,
      'imagePath': imagePath,
    };
  }
}
