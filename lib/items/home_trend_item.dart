import 'package:flutter/material.dart';

class HomeTrendItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final String time;

  HomeTrendItem(this.id, this.title, this.image, this.time);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: (){},
        child: Container(
          width: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // căn chỉnh về phía dưới
              crossAxisAlignment: CrossAxisAlignment.start, // căn chỉnh về phía trái
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
