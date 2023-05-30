import 'package:flutter/material.dart';

class DealViewModel{
  final String id;
  final String title;
  final String image;
  final String time;
  final String script;
  final String meal;

  const DealViewModel({required this.id,required this.title, required this.image, required this.time, required this.script, required this.meal});
}