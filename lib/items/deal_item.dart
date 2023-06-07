import 'package:flutter/material.dart';

import '../pages/deal_view.dart';

class DealItem extends StatelessWidget {
  final int id;
  final String title;
  const DealItem(this.id, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DealView(id: id, title: title)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius:
                BorderRadius.circular(20), // Thêm border radius vào đây
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
