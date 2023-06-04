import 'package:flutter/material.dart';

class ViewDetailIngredientItem extends StatelessWidget {
  final int id;
  final String title;
  final double amount;
  final String unit;
  const ViewDetailIngredientItem(this.id, this.title, this.amount, this.unit,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text("$amount $unit",
              style: const TextStyle(fontSize: 20, color: Colors.deepOrange)),
        ),
      ],
    );
  }
}
