// class CommentModel{
//   final String id;
//   final String name;
//   final String date;
//   final String image;
//   final String comment;

//   const CommentModel({required this.id,required this.name,required this.date,required this.image, required this.comment});
// }

import 'package:firstapp/models/user_model.dart';

class CommentModel {
  final int id;
  final String description;
  final DateTime createdDate;
  final DateTime editedDate;
  final String status;
  final UserModel user;

  CommentModel({
    required this.id,
    required this.description,
    required this.createdDate,
    required this.editedDate,
    required this.status,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      description: json['description'],
      createdDate: DateTime(
        json['createdDate'][0],
        json['createdDate'][1],
        json['createdDate'][2],
        json['createdDate'][3],
        json['createdDate'][4],
        json['createdDate'][5],
      ),
      editedDate: DateTime(
        json['editedDate'][0],
        json['editedDate'][1],
        json['editedDate'][2],
        json['editedDate'][3],
        json['editedDate'][4],
        json['editedDate'][5],
      ),
      status: json['status'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
