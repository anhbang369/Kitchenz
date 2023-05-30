import 'package:flutter/material.dart';

class ViewDetailIngredientItem extends StatelessWidget {
  final String id;
  final String title;
  final String amount;
  ViewDetailIngredientItem(this.id, this.title, this.amount);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(title,maxLines: 1,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20)),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(amount, style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
        ),
      ],
    );

  }
}
