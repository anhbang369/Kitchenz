import 'package:flutter/material.dart';

import '../models/category_view_model.dart';

class ManageRecipe extends StatefulWidget {
  const ManageRecipe({Key? key}) : super(key: key);

  @override
  State<ManageRecipe> createState() => _ManageRecipeState();
}

class _ManageRecipeState extends State<ManageRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Bài đã đăng'),
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black,width: 1)
              ),
              child: TextFormField(
                autofocus: false,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Tìm kiếm",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 132, 140, 155)),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          /*Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: DEALVIEW_DATA
                    .map((item) =>
                    CategoryViewItem(item.id, item.title, item.image, item.time, item.script, item.meal))
                    .toList(),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

const DEALVIEW_DATA = [
  CategoryViewModel(id: '1', title: 'Cơm gà Đà Nẵng', image: 'https://youindanang.com/wp-content/uploads/2017/09/Com-Ga-Chicken-Rice-01-1.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  CategoryViewModel(id: '2', title: 'Bún chả cá', image: 'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  CategoryViewModel(id: '3', title: 'Hủ tiếu Nam Vang', image: 'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  CategoryViewModel(id: '4', title: 'Bán cuốn', image: 'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  CategoryViewModel(id: '2', title: 'Bún chả cá', image: 'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  CategoryViewModel(id: '3', title: 'Hủ tiếu Nam Vang', image: 'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),
  CategoryViewModel(id: '4', title: 'Bán cuốn', image: 'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg', time: 'Thời gian: 45 phút', script: 'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....', meal: 'Bữa sáng'),

];
