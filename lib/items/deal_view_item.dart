import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import '../pages/view_detail.dart';

class DealViewItem extends StatefulWidget {
  final int id;
  final String title;
  final String image;
  final double time;
  final String script;
  final bool isVip;
  final List<String> likes;

  const DealViewItem(this.id, this.title, this.image, this.time, this.script,
      this.isVip, this.likes,
      {super.key});

  @override
  _DealViewItemState createState() => _DealViewItemState();
}

class _DealViewItemState extends State<DealViewItem> {
  bool _isFavorited = false;
  UserModel? currentUser;

  void _toggleFavorite() {
    // Check if user is logged in
    if (currentUser != null) {
      ApiService.likeDish(currentUser!.id, widget.id).then((value) {
        if (value) {
          setState(() {
            _isFavorited = !_isFavorited;
          });
        }
      });
    }
    // setState(() {
    //   _isFavorited = !_isFavorited;
    // });
  }

  @override
  void initState() {
    ApiService.getCurrentUser().then((value) {
      setState(() {
        currentUser = value;
        // Check if user has liked this deal
        _isFavorited = widget.likes.contains(currentUser!.id.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewDetail(id: widget.id)),
        );
      },
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              widget.isVip ? 'VIP' : '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
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
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(widget.time.toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.script,
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
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorited ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          _toggleFavorite();
                        },
                        splashRadius: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
