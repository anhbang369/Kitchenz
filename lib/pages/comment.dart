import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../items/comment_item.dart';

class Comment extends StatefulWidget {
  Comment({required this.comments, required this.dishId, Key? key})
      : super(key: key);
  List<CommentModel> comments;
  int dishId;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  String description = '';
  final filedTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Những đánh giá'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Để lại đánh giá của bạn',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: filedTextController,
                    onChanged: (value) => setState(() {
                      description = value;
                    }),
                    minLines: 2,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Viết một cái gì đó...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                if (description == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bạn chưa nhập đánh giá'),
                    ),
                  );
                } else {
                  ApiService.comment(widget.dishId, description).then((cmt) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đánh giá thành công'),
                      ),
                    );
                    setState(() {
                      filedTextController.clear();
                    });
                  });
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: const Text(
                        'Gửi',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.comments
                    .map((cmt) => CommentItem(
                          cmt.id,
                          cmt.user.username,
                          cmt.createdDate.toString().split('.')[0],
                          cmt.user.imageUrl,
                          cmt.description,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// const COMMENT_DATA = [
//   CommentModel(
//       id: '1',
//       name: 'Suna',
//       date: '15/03/2023',
//       image:
//           'https://photocross.net/wp-content/uploads/2020/03/anh-chan-dung.jpg',
//       comment:
//           'Whether you are working on a new cutting edge app or simply ramping up on new technology, Java documentation has all the information you need to make your project a smashing success. Use the rich set of code samples, tutorials, developer guides, API documentation, and more to quickly develop your prototype'),
//   CommentModel(
//       id: '2',
//       name: 'Luna',
//       date: '15/03/2023',
//       image:
//           'https://haycafe.vn/wp-content/uploads/2022/03/anh-chan-dung-1.jpg',
//       comment:
//           'Whether you are working on a new cutting edge app or simply ramping up on new technology, Java documentation has all the information you need to make your project a smashing success. Use the rich set of code samples, tutorials, developer guides, API documentation, and more to quickly develop your prototype'),
// ];
