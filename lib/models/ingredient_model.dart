class IngredientModel {
  final int id;
  final String name;
  final String unit;

  IngredientModel({
    required this.id,
    required this.name,
    required this.unit,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
    );
  }

  // toJson()
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
    };
  }
}
