import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/category_post_view_model.dart';
import 'package:firstapp/network/NetworkRequest.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CategoryViewItem2 extends StatefulWidget {
  const CategoryViewItem2({Key? key}) : super(key: key);

  @override
  State<CategoryViewItem2> createState() => _CategoryViewItem2State();
}

class _CategoryViewItem2State extends State<CategoryViewItem2> {
  List<CategoryPostViewModel> postData1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest2.fetchPosts().then((value) {
      setState(() {
        postData1 = value;
      });
    });
  }

  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('so luong gia tri ${postData1.length}');
    return Container(
      color: Colors.green,
      height: 500,
      child: ListView.builder(
          itemCount: postData1.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 365,
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 108,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${postData1[index].imageUrl}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 195,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              utf8.decode(postData1[index].name!.codeUnits),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('24 phút'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              utf8.decode(
                                  postData1[index].description!.codeUnits),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FirebaseAuth.instance.currentUser?.uid ==
                            'BKJq8xaAnHhIhe8AnUEmLPpraqo1'
                        ? Container(
                            margin: EdgeInsets.only(bottom: 80),
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: _toggleFavorite,
                              splashRadius: 1,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: IconButton(
                              icon: Icon(
                                _isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isFavorited ? Colors.red : Colors.black,
                              ),
                              onPressed: _toggleFavorite,
                              splashRadius: 1,
                            ),
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
