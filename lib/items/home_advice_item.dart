import 'package:flutter/material.dart';

class HomeAdviceItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  HomeAdviceItem(this.id,this.title,this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Border radius ở đây
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 22,color: Colors.grey)),
        ),
      ),
    );




  }
}
