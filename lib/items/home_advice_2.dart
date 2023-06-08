import 'package:flutter/material.dart';

class HomeAdvice2 extends StatefulWidget {
  const HomeAdvice2({Key? key}) : super(key: key);

  @override
  State<HomeAdvice2> createState() => _HomeAdvice2State();
}

class _HomeAdvice2State extends State<HomeAdvice2> {
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
              'Chất dinh dưỡng nên bổ xung vào mùa hè.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Image(
                image: NetworkImage(
                    'https://naganic.vn/wp-content/uploads/2021/10/rau-cu-giau-dinh-duong.jpg')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Trong mùa hè, khi nhiệt độ cao và hoạt động thể chất tăng lên, có một số chất dinh dưỡng cụ thể bạn nên bổ sung để duy trì sức khỏe và sức sống. Dưới đây là một số chất dinh dưỡng quan trọng nên bổ sung vào mùa hè:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Nước: Trong mùa hè, cơ thể cần được cung cấp đủ nước để duy trì sự cân bằng lỏng và tránh bị mất nước. Hãy uống đủ nước hàng ngày và tránh tiếp xúc quá lâu với ánh nắng mặt trời nếu không cần thiết.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Vitamin C: Vitamin C giúp tăng cường hệ miễn dịch và bảo vệ cơ thể khỏi tổn thương từ tác động của tia tử ngoại. Quả cam, dứa, dâu tây, kiwi và các loại quả berry là nguồn tốt của vitamin C.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Kali: Kali là một khoáng chất quan trọng giúp duy trì cân bằng nước trong cơ thể và chức năng cơ bắp. Nhiều loại rau xanh lá như cải bó xôi, bông cải xanh, rau muống và chuối đều giàu kali.',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
