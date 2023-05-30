import 'package:flutter/material.dart';
import '../models/favorite_model.dart';
import '../items/favorite_item.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Yêu thích'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: ListView(
          children: DEALVIEW_DATA
              .map((item) =>
              FavoriteItem(item.id, item.title, item.image, item.time, item.script, item.meal))
              .toList(),
        ),
      ),
    );
  }
}

const DEALVIEW_DATA = [
  FavoriteModel(id: '1', title: 'Cơm gà Đà Nẵng', image: 'https://youindanang.com/wp-content/uploads/2017/09/Com-Ga-Chicken-Rice-01-1.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  FavoriteModel(id: '2', title: 'Bún chả cá', image: 'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  FavoriteModel(id: '3', title: 'Hủ tiếu Nam Vang', image: 'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  FavoriteModel(id: '4', title: 'Bán cuốn', image: 'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  FavoriteModel(id: '2', title: 'Bún chả cá', image: 'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  FavoriteModel(id: '3', title: 'Hủ tiếu Nam Vang', image: 'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  FavoriteModel(id: '4', title: 'Bán cuốn', image: 'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),

];
