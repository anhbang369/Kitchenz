import 'package:firstapp/models/view_detail_step_model.dart';

class Dish {
  final int id;
  final String name;
  final String description;
  final int viewNumber;
  final double duration;
  final String status;
  final String imageUrl;
  final List<ViewDetailStepModel> steps;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.viewNumber,
    required this.duration,
    required this.status,
    required this.imageUrl,
    required this.steps,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    // Check if json['steps']['status'] not deactive
    json['steps'] = json['steps']
        .where((step) => step['status'] == 'ACTIVE')
        .toList(growable: false);
    return Dish(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      viewNumber: json['viewNumber'],
      duration: json['duration'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      steps: List<ViewDetailStepModel>.from(
          json['steps'].map((x) => ViewDetailStepModel.fromJson(x))),
    );
  }
}
