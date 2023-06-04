import 'package:firstapp/pages/view_detail.dart';
import 'package:flutter/material.dart';

class HomeTrendItem extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final double time;

  const HomeTrendItem(this.id, this.title, this.image, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewDetail(id: id)));
        },
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
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // căn chỉnh về phía dưới
              crossAxisAlignment:
                  CrossAxisAlignment.start, // căn chỉnh về phía trái
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  '${time.ceil()} phút',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
