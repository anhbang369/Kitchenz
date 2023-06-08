import 'package:flutter/material.dart';

class HomeAdvice extends StatefulWidget {
  const HomeAdvice({Key? key}) : super(key: key);

  @override
  State<HomeAdvice> createState() => _HomeAdviceState();
}

class _HomeAdviceState extends State<HomeAdvice> {
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
              'Những loại thức ăn giúp bạn cải thiện sức khỏe.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Image(
                image: NetworkImage(
                    'https://cdn.suckhoechomoinha.org/wp-content/uploads/2016/07/meo-giu-rau-cu-qua-luon-sach-va-tuoi-ngon-1.jpg')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Rau xanh: Rau xanh như rau cải, rau xanh lá, rau bina, rau mầm chứa nhiều chất xơ, vitamin và khoáng chất. Chúng giúp cung cấp năng lượng, bảo vệ cơ thể khỏi các bệnh tật và duy trì hệ tiêu hóa lành mạnh.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Trái cây: Trái cây như quả dứa, táo, cam, kiwi, dưa hấu và các loại berry như việt quất và dâu tây chứa nhiều chất chống oxy hóa và vitamin C. Chúng giúp tăng cường hệ miễn dịch, cung cấp chất chống vi khuẩn và giảm nguy cơ mắc các bệnh mãn tính.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Hạt và ngũ cốc nguyên hạt: Hạt như hạt lanh, hạt chia và hạt hướng dương cùng với các ngũ cốc nguyên hạt như yến mạch, lúa mạch và lạc chứa nhiều chất xơ, protein và chất béo không bão hòa. Chúng giúp cải thiện chức năng tim mạch, duy trì cân nặng và cung cấp năng lượng kéo dài.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Các loại cá hợp chất omega-3: Các loại cá như cá hồi, cá thu, cá mackerel và cá trích chứa nhiều axit béo omega-3. Chúng có tác dụng chống viêm, bảo vệ tim mạch và cải thiện chức năng não.',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
