import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/pages/menu.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Xác thực email'),
        /*leading: Stack(
          children: [
            Positioned(
              top: 8,
              right: 0,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.deepOrange,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
                // Chỉnh vị trí của mũi tên để nằm ở giữa hình tròn
                alignment: Alignment.center,
              ),
            ),
          ],
        ),*/
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Text('Vui lòng kiểm tra email của bạn và xác thực tài khoản để tiếp tục.',style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Container(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.currentUser!.reload(); // Tải lại thông tin người dùng để cập nhật trạng thái xác thực email
                    if(FirebaseAuth.instance.currentUser!.emailVerified){ // Kiểm tra xem email đã được xác thực hay chưa
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu(title: ''))); // Nếu đã xác thực email thì chuyển đến trang chính
                    }
                  },
                  child: Text('Đã xác thực email',),
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
      ),
    );
  }
}