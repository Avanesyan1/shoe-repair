class WorkModel {
  final int id;
  final String name;
  final String submissionDeadline;
  final String comment;
  final int price;
  final String shoeName;
  final String material;

  WorkModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.submissionDeadline,
    required this.price,
    required this.shoeName,
    required this.material,
  });

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      id: map['id'],
      name: map['name'],
      submissionDeadline: map['submissionDeadline'],
      comment: map['comment'],
      price: map['price'],
      shoeName: map['shoeName'],
      material: map['material'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'submissionDeadline': submissionDeadline,
      'price': price,
      'comment': comment,
      'shoeName': shoeName,
      'material': material,
    };
  }
}
