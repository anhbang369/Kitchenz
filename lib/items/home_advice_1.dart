import 'package:flutter/material.dart';

class HomeAdvice1 extends StatefulWidget {
  const HomeAdvice1({Key? key}) : super(key: key);

  @override
  State<HomeAdvice1> createState() => _HomeAdvice1State();
}

class _HomeAdvice1State extends State<HomeAdvice1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Lời khuyên'),
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
                child: Text(
              'Rau củ mang nhiều chất dinh dưỡng hơn bạn nghĩ.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Image(
                image: NetworkImage(
                    'https://bimivn.com/hoanghung/5/images/C%C3%A1ch%20ch%E1%BB%8Dn%20mua%20rau%20c%E1%BB%A7%20qu%E1%BA%A3%20s%E1%BA%A1ch.jpg')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Chất xơ: Rau củ, như cà rốt, cải xoăn, rau xanh lá, củ cải, và đậu hà lan, đều chứa nhiều chất xơ. Chất xơ giúp tăng cường chức năng tiêu hóa, giảm nguy cơ bệnh tật đường ruột, duy trì cân nặng, và giảm nguy cơ bệnh tim mạch.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Vitamin và khoáng chất: Rau củ chứa nhiều loại vitamin và khoáng chất cần thiết cho cơ thể. Ví dụ, cà chua là nguồn tuyệt vời của vitamin C và khoáng chất như kali và lycopene, cải xoăn chứa vitamin K và axit folic, cà rốt chứa beta-carotene và vitamin A, và rau xanh lá chứa vitamin K, A, và C.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Chất chống oxy hóa: Rau củ thường chứa các chất chống oxy hóa, như các polyphenol và carotenoid. Những chất này giúp bảo vệ tế bào khỏi tổn thương do các gốc tự do và có thể giảm nguy cơ mắc các bệnh mãn tính như bệnh tim mạch, ung thư, và bệnh tiểu đường.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Canxi: Một số loại rau củ như bông cải xanh, rau cải bó xôi và cải xoăn chứa canxi, một khoáng chất quan trọng cho sự phát triển và duy trì xương và răng khỏe mạnh.',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
