import 'package:flutter/material.dart';

class ViewDetailNutritionItem extends StatelessWidget {
  final int id;
  final String title;
  final double amount;
  final String unit;
  const ViewDetailNutritionItem(this.id, this.title, this.amount, this.unit,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(title),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text('$amount'),
            ),
          ),
        ],
      ),
    );
  }
}
