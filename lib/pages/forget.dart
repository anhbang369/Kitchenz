import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/pages/sign_up.dart';

class FogetPassword extends StatefulWidget {
  const FogetPassword({Key? key}) : super(key: key);

  @override
  State<FogetPassword> createState() => _FogetPasswordState();
}

class _FogetPasswordState extends State<FogetPassword> {
  TextEditingController _emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Quên mật khẩu')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Center(child: Text('Vui lòng nhập email của bạn để đặt lại mật khẩu, chúng tôi sẽ gửi liên kết khôi phục đến email của bạn.', textAlign: TextAlign.center,),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
            child: TextField(
              controller: _emailEditingController,
              decoration: InputDecoration(
                hintText: 'Nhập mật email của bạn',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Icon(Icons.mail),
              ),
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Container(
              width: 700,
              height: 60,
              child: ElevatedButton(
                  onPressed: () async {
                    var forgetEmail = _emailEditingController.text.trim();
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgetEmail).then((value) => {
                        print('send email!'),
                      });
                    }on FirebaseAuthException catch(e){
                      print('Error $e');
                    }
                  },
                  child: Text('Gửi'),
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
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Không có tài khoản?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      // Xử lý sự kiện chuyển sang trang SignUp ở đây
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      'Tạo tài khoản?',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
