import 'package:flutter/material.dart';

class ViewDetailStepItem extends StatelessWidget {
  final int id;
  final String title;
  final String script;
  const ViewDetailStepItem(this.id, this.title, this.script, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffC4C4C4),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "Bước $title",
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                script,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
