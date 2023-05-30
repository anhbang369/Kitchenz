import 'package:flutter/material.dart';
import '../models/deal_model.dart';
import '../items/deal_item.dart';

class DealPage extends StatelessWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Chế độ ăn'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20), // Thêm border radius vào đây
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Thực đơn theo tuần',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _post.map<Widget>((item) => DealItem(item.id,item.title)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

final List<DealModel> _post = <DealModel>[
  const DealModel(id: '1', title: 'Thực đơn tiêu chuẩn'),
  const DealModel(id: '2', title: 'Chế độ tăng cân'),
  const DealModel(id: '3', title: 'Chế độ giảm cân'),
  const DealModel(id: '3', title: 'Chế độ rèn luyện sức khỏe'),
];
