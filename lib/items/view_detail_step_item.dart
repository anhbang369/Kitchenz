import 'package:flutter/material.dart';

class ViewDetailStepItem extends StatelessWidget {
  final String id;
  final String title;
  final String script;
  ViewDetailStepItem(this.id, this.title, this.script);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffC4C4C4),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(title, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(script,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
