import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/verify_email.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Tạo tài khoản',
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nhập tên tài khoản',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Icon(Icons.person),
              ),
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextField(
              controller: _emailEditingController,
              decoration: InputDecoration(
                hintText: 'Nhập email của bạn',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextField(
              controller: _passwordEditingController,
              decoration: InputDecoration(
                hintText: 'Nhập mật khẩu của bạn',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: signUpButton(context, false, () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailEditingController.text,
                      password: _passwordEditingController.text)
                  .then((value) {
                    value.user!.sendEmailVerification();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => VerifyEmailPage()));
              }).catchError((error) {
                // In ra thông báo lỗi
                print("Đã xảy ra lỗi: $error");
              });
            }),
          ),
        ],
      ),
    );
  }

  Container signUpButton(BuildContext context, bool isLogin, Function ontap) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: () {
          ontap();
        },
        child: Center(
          child: Text(
            'Đăng kí',
            style: TextStyle(color: Colors.white, fontSize: 20),
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
    );
  }
}
