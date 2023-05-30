import 'package:flutter/material.dart';

class CommentModel{
  final String id;
  final String name;
  final String date;
  final String image;
  final String comment;

  const CommentModel({required this.id,required this.name,required this.date,required this.image, required this.comment});
}