import 'package:firstapp/items/home_advice.dart';
import 'package:firstapp/items/home_advice_1.dart';
import 'package:firstapp/items/home_advice_2.dart';
import 'package:flutter/material.dart';

class HomeAdviceItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  HomeAdviceItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          if (id == "1") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeAdvice()),
            );
          } else if (id == "2") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeAdvice1()),
            );
          } else if (id == "3") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeAdvice2()),
            );
          }
        },
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(title, style: TextStyle(fontSize: 22, color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}
