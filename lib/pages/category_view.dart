import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/category_model.dart';
import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/pages/view_detail.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';

import '../models/category_post_view_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final List<CategoryPostViewModel> _post = [];
  List<CategoryPostViewModel> _postDisplay = List.empty(growable: true);
  UserModel? currentUser;

  @override
  void initState() {
    ApiService.getCurrentUser().then((user) {
      setState(() {
        currentUser = user;
      });
      ApiService.fetchDishOfCategory(widget.category.id).then((value) {
        setState(() {
          _post.addAll(value);
          _postDisplay = _post;
        });
      });
    });
    super.initState();

    // NetworkRequest.fetchPosts().then((value) {
    //   setState(() {
    //     _post.addAll(value);
    //     _postDisplay = _post;
    //   });
    // });
  }

  bool _isFavorited = false;

  void _toggleFavorite(int index) {
    setState(() {
      if (_postDisplay[index].likes!.contains(currentUser!.id.toString())) {
        _postDisplay[index].likes!.remove(currentUser!.id.toString());
      } else {
        _postDisplay[index].likes!.add(currentUser!.id.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.category.name),
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
      body: ListView.builder(
          itemCount: _postDisplay.length + 1,
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index - 1);
          }),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(hintText: 'Tìm ...'),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ViewDetail(id: _postDisplay[index].id!)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
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
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            _postDisplay[index].isVip == true ? 'VIP' : '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 195,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _postDisplay[index].name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            '${_postDisplay[index].duration!.ceil()} phút'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _postDisplay[index].description ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    icon: Icon(
                      checkUserHasLike(index)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          checkUserHasLike(index) ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      ApiService.likeDish(
                              currentUser!.id, _postDisplay[index].id!)
                          .then((value) {
                        if (value == true) {
                          // Reload list of posts
                          ApiService.fetchDishOfCategory(widget.category.id)
                              .then((value) {
                            setState(() {
                              _post.clear();
                              _post.addAll(value);
                              _postDisplay = _post;
                            });
                          });
                        }
                      });
                    },
                    splashRadius: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkUserHasLike(int index) {
    if (currentUser != null && _postDisplay[index].likes != null) {
      return _postDisplay[index].likes!.contains(currentUser!.id.toString());
    }
    return false;
  }
}
