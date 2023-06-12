import 'package:firstapp/models/dish_model.dart';
import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/pages/view_detail.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import '../items/favorite_item.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<DishModel> dishes = [];
  UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Yêu thích'),
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
      body: FutureBuilder(
          future: ApiService.getCurrentUser(),
          builder: (context, user) {
            currentUser = user.data;
            if (user.hasData) {
              return FutureBuilder(
                future: ApiService.getLikedDish(user.data!.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dishes = snapshot.data as List<DishModel>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 7),
                      child: ListView(
                        children: dishes
                            .map((dish) => buildFavorateItem(
                                  dish.id,
                                  dish.name,
                                  dish.imageUrl,
                                  dish.duration.ceil().toString(),
                                  dish.description,
                                  dish.isVip,
                                ))
                            .toList(),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget buildFavorateItem(int id, String name, String imageUrl, String time,
      String script, bool isVip) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewDetail(id: id))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffFAFAFA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 108,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
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
                              isVip ? 'VIP' : '',
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
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('$time phút'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            script,
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
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await ApiService.likeDish(currentUser!.id, id)
                            .then((_) {
                          setState(() {
                            dishes.removeWhere((dish) => dish.id == id);
                          });
                        });
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
    );
  }
}

// const DEALVIEW_DATA = [
//   FavoriteModel(
//       id: '1',
//       title: 'Cơm gà Đà Nẵng',
//       image:
//           'https://youindanang.com/wp-content/uploads/2017/09/Com-Ga-Chicken-Rice-01-1.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   FavoriteModel(
//       id: '2',
//       title: 'Bún chả cá',
//       image:
//           'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   FavoriteModel(
//       id: '3',
//       title: 'Hủ tiếu Nam Vang',
//       image:
//           'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   FavoriteModel(
//       id: '4',
//       title: 'Bán cuốn',
//       image:
//           'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   FavoriteModel(
//       id: '2',
//       title: 'Bún chả cá',
//       image:
//           'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   FavoriteModel(
//       id: '3',
//       title: 'Hủ tiếu Nam Vang',
//       image:
//           'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   FavoriteModel(
//       id: '4',
//       title: 'Bán cuốn',
//       image:
//           'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
// ];

