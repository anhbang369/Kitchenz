import 'package:flutter/material.dart';

class ViewDetailNutritionItem extends StatelessWidget {
  final String id;
  final String title;
  final int amount;
  ViewDetailNutritionItem(this.id, this.title, this.amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(title),
            ),
          ),
          SizedBox(width: 35),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(amount.toString()),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(15),
      ),
    );

  }
}
