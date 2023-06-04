class CategoryModel {
  final int id;
  final String name;
  final String imageUrl;
  final int numOfDish;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.numOfDish,
  });

  //From json
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      numOfDish: json['dishCategories'].length,
    );
  }
}
