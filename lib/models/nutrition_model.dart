class NutritionModel {
  final int id;
  final String name;
  final String unit;

  NutritionModel({
    required this.id,
    required this.name,
    required this.unit,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
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
