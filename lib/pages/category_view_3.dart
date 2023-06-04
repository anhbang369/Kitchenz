import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/category_post_view_model.dart';
import '../network/NetworkRequest.dart';

class CategoryView3 extends StatefulWidget {
  const CategoryView3({Key? key}) : super(key: key);

  @override
  State<CategoryView3> createState() => _CategoryView3State();
}

class _CategoryView3State extends State<CategoryView3> {
  List<CategoryPostViewModel> _post = [];
  List<CategoryPostViewModel> _postDisplay = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest3.fetchPosts().then((value) {
      setState(() {
        _post.addAll(value);
        _postDisplay = _post;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Bữa sáng'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: _postDisplay.length + 1,
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index - 1);
          }),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Tìm ...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _postDisplay = _post.where((postData) {
              var posttile = postData.name
                  ?.toLowerCase(); // Add a null check using the null-aware operator '?'
              return posttile != null &&
                  posttile.contains(
                      text); // Check if posttile is not null before calling contains()
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
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
                    image: NetworkImage('${_postDisplay[index].imageUrl}'),
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
                        utf8.decode(_postDisplay[index].name!.codeUnits),
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
                        utf8.decode(_postDisplay[index].description!.codeUnits),
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
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorited ? Colors.red : Colors.black,
                        ),
                        onPressed: _toggleFavorite,
                        splashRadius: 1,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
