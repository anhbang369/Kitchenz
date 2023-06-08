import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/home_trend_model.dart';
import 'package:firstapp/pages/payment.dart';
import 'package:firstapp/pages/profile.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:firstapp/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../items/home_advice_item.dart';
import '../models/home_advice_model.dart';
import '../items/home_trend_item.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/main.dart';
import 'package:firstapp/pages/favorite.dart';

import 'create_recipe.dart';
import 'manage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Trang chủ'),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orangeAccent,
                ]),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: FirebaseAuth.instance.currentUser?.photoURL != null
                          ? Image.network(
                              FirebaseAuth.instance.currentUser!.photoURL!,
                              width: 100,
                              height: 100,
                            )
                          : const Icon(Icons.person, size: 100),
                    ),
                    const Padding(padding: EdgeInsets.all(3)),
                    Text(
                      '${FirebaseAuth.instance.currentUser?.displayName ?? "Anonymous"}',
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            CustomerListTitle(
              Icons.person,
              'Hồ sơ',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile())),
            ),
            CustomerListTitle(
              Icons.favorite,
              'Yêu thích',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Favorite())),
            ),
            CustomerListTitle(
              Icons.fastfood_outlined,
              'Tạo món',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateRecipe())),
            ),
            CustomerListTitle(
              Icons.fastfood_outlined,
              'Quản lý bài đăng',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Manage())),
            ),
            CustomerListTitle(
              Icons.payment,
              'Thanh toán',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Payment())),
            ),
            CustomerListTitle(Icons.settings, 'Cài đặt', () => {}),
            CustomerListTitle(Icons.notifications, 'Thông báo', () => {}),
            CustomerListTitle(Icons.logout, 'Đăng xuất', () async {
              await ApiService.logout();
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              });
            }),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Chào mừng đến KitchenZ.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    print(currentIndex);
                  },
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.network(
                            item['image_path'],
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      height: 120,
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        currentIndex = index;
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          currentIndex = entry.key;
                          carouselController.animateToPage(entry.key);
                        },
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == entry.key
                                ? Colors.red
                                : Colors.teal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Row(
              children: [
                Text(
                  'Xu hướng',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //Icon(Icons.fireplace_sharp),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: FutureBuilder(
                future: ApiService.getTop5Dish(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!
                          .map(
                            (item) => HomeTrendItem(item.id, item.name,
                                item.imageUrl, item.duration, item.isVip),
                          )
                          .toList(),
                    );
                  }
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Text(
              'Lời khuyên lành mạnh',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: ADVICE_DATA
                .map(
                  (item) => HomeAdviceItem(item.id, item.title, item.image),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

List imageList = [
  {
    "id": 1,
    "image_path":
        'https://www.aucklandbotanicgardens.co.nz/media/1265/autumn-apr-lake_j9k0704.jpg?anchor=center&mode=crop&width=970&height=400&rnd=133092835373370000'
  },
  {
    "id": 2,
    "image_path":
        'https://www.almanac.com/sites/default/files/styles/or/public/image_nodes/spring-1210194_1280.jpg?itok=HgToutem'
  },
  {
    "id": 3,
    "image_path":
        'https://www.shutterstock.com/image-vector/spring-background-text-handwriting-hello-260nw-1926380885.jpg'
  }
];
final CarouselController carouselController = CarouselController();
int currentIndex = 0;

const ADVICE_DATA = [
  HomeAdviceModel(
      id: '1',
      title: 'Những loại thức ăn giúp bạn cải thiện sức khỏe.',
      image:
          'https://cdn.suckhoechomoinha.org/wp-content/uploads/2016/07/meo-giu-rau-cu-qua-luon-sach-va-tuoi-ngon-1.jpg'),
  HomeAdviceModel(
      id: '2',
      title: 'Rau củ mang nhiều chất dinh dưỡng hơn bạn nghĩ.',
      image:
          'https://bimivn.com/hoanghung/5/images/C%C3%A1ch%20ch%E1%BB%8Dn%20mua%20rau%20c%E1%BB%A7%20qu%E1%BA%A3%20s%E1%BA%A1ch.jpg'),
  HomeAdviceModel(
      id: '3',
      title: 'Chất dinh dưỡng nên bổ xung vào mùa hè.',
      image:
          'https://naganic.vn/wp-content/uploads/2021/10/rau-cu-giau-dinh-duong.jpg'),
];

class CustomerListTitle extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback onTap;

  CustomerListTitle(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        splashColor: Colors.deepOrange,
        onTap: onTap,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_right)
            ],
          ),
        ),
      ),
    );
  }
}
