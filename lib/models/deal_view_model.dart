import 'package:equatable/equatable.dart';
import 'package:firstapp/models/dish_model.dart';

class DealViewModel extends Equatable {
  final int id;
  final String name;
  final List<DealViewDayModel> days;

  const DealViewModel({
    required this.id,
    required this.name,
    required this.days,
  });

  factory DealViewModel.fromJson(Map<String, dynamic> json) {
    return DealViewModel(
      id: json['id'],
      name: json['name'],
      days: List<DealViewDayModel>.from(
          json['days'].map((x) => DealViewDayModel.fromJson(x))),
    );
  }

  @override
  List<Object> get props => [id, name, days];
}

class DealViewDayModel {
  final int id;
  final int dayOrder;
  final List<DealViewDayDetailModel> dayDetails;

  const DealViewDayModel(
      {required this.id, required this.dayOrder, required this.dayDetails});

  factory DealViewDayModel.fromJson(Map<String, dynamic> json) {
    return DealViewDayModel(
      id: json['id'],
      dayOrder: json['dayOrder'],
      dayDetails: List<DealViewDayDetailModel>.from(
          json['dayDetails'].map((x) => DealViewDayDetailModel.fromJson(x))),
    );
  }
}

class DealViewDayDetailModel {
  final int id;
  final DishModel dish;

  const DealViewDayDetailModel({required this.id, required this.dish});

  factory DealViewDayDetailModel.fromJson(Map<String, dynamic> json) {
    return DealViewDayDetailModel(
      id: json['id'],
      dish: DishModel.fromJson(json['dish']),
    );
  }
}
