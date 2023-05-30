import 'package:flutter/material.dart';

class CreateDeal extends StatefulWidget {
  const CreateDeal({Key? key}) : super(key: key);

  @override
  State<CreateDeal> createState() => _CreateDealState();
}

class _CreateDealState extends State<CreateDeal> {
  TextEditingController nutrition = TextEditingController();
  TextEditingController nutritionAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Tạo chế độ ăn'),
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
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: TextField(
              controller: nutrition,
              decoration: InputDecoration(
                hintText: 'Nhập tên chế độ',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: TextField(
              controller: nutritionAmount,
              decoration: InputDecoration(
                hintText: 'Ngày thứ mấy',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: TextFormField(
              autofocus: false,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: TextStyle(color: Color.fromARGB(255, 132, 140, 155)),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            color: Colors.green,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'Thêm',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return Colors.deepOrange;
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
