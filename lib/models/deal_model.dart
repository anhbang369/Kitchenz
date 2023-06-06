class DealModel {
  final int id;
  final String name;

  const DealModel({required this.id, required this.name});

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
