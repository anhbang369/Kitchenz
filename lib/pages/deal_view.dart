import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import '../models/deal_view_model.dart';
import '../items/deal_view_item.dart';

class DealView extends StatefulWidget {
  const DealView({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  _DealViewState createState() => _DealViewState();
}

class _DealViewState extends State<DealView> {
  final items = ['item1', 'item 2', 'item 3'];
  String? value;

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
        title: const Text('Thực đơn tiêu chuẩn'),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Container(
                  width: 150,
                  height: 32,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: value,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<DealViewModel>(
                future: ApiService.getDealDetail(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: snapshot.data!.days.expand((day) {
                          return day.dayDetails.map((dayDetail) {
                            return DealViewItem(
                              dayDetail.dish.id,
                              dayDetail.dish.name,
                              dayDetail.dish.imageUrl,
                              dayDetail.dish.duration,
                              dayDetail.dish.description,
                              dayDetail.dish.isVip,
                            );
                          });
                        }).toList(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        alignment: Alignment.center,
        child: Text(
          item,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

// const DEALVIEW_DATA = [
//   DealViewModel(
//       id: '1',
//       title: 'Cơm gà Đà Nẵng',
//       image:
//           'https://youindanang.com/wp-content/uploads/2017/09/Com-Ga-Chicken-Rice-01-1.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   DealViewModel(
//       id: '2',
//       title: 'Bún chả cá',
//       image:
//           'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   DealViewModel(
//       id: '3',
//       title: 'Hủ tiếu Nam Vang',
//       image:
//           'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   DealViewModel(
//       id: '4',
//       title: 'Bán cuốn',
//       image:
//           'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//           'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   DealViewModel(
//       id: '2',
//       title: 'Bún chả cá',
//       image:
//       'https://cdn.tgdd.vn/2021/09/CookRecipe/Avatar/bun-cha-ca-nha-trang-thumbnail.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//       'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   DealViewModel(
//       id: '3',
//       title: 'Hủ tiếu Nam Vang',
//       image:
//       'https://www.disneycooking.com/wp-content/uploads/2020/11/hu-tieu-nam-vang.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//       'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
//   DealViewModel(
//       id: '4',
//       title: 'Bán cuốn',
//       image:
//       'https://www.cet.edu.vn/wp-content/uploads/2021/12/cach-lam-banh-cuon-nong.jpg',
//       time: 'Thời gian: 45 phút',
//       script:
//       'Các nguyên liệu cần có: Cơm, lạp xướng, trứng, cà rốt, đậu que, ....',
//       meal: 'Bữa sáng'),
// ];
