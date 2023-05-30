import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../items/comment_item.dart';

class Comment extends StatelessWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Những đánh giá'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Text('Để lại đánh giá của bạn', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Viết một cái gì đó...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 150,

                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                  child: Text('Gửi', style: TextStyle(fontSize: 20, color: Colors.white),),
                ),),
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: COMMENT_DATA
                      .map((item) =>
                      CommentItem(item.id, item.name, item.date, item.image, item.comment))
                      .toList(),
                ),
              ),
          ),

        ],
      ),
    );
  }
}

const COMMENT_DATA = [
  CommentModel(id: '1', name: 'Suna', date: '15/03/2023', image: 'https://photocross.net/wp-content/uploads/2020/03/anh-chan-dung.jpg', comment: 'Whether you are working on a new cutting edge app or simply ramping up on new technology, Java documentation has all the information you need to make your project a smashing success. Use the rich set of code samples, tutorials, developer guides, API documentation, and more to quickly develop your prototype'),
  CommentModel(id: '2', name: 'Luna', date: '15/03/2023', image: 'https://haycafe.vn/wp-content/uploads/2022/03/anh-chan-dung-1.jpg', comment: 'Whether you are working on a new cutting edge app or simply ramping up on new technology, Java documentation has all the information you need to make your project a smashing success. Use the rich set of code samples, tutorials, developer guides, API documentation, and more to quickly develop your prototype'),
];
