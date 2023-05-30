import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'menu.dart';
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _rememberMe = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
      await firebaseAuth.signInWithCredential(credential);

      final User? user = authResult.user;

      if (user != null) {
        // Đăng nhập thành công, trả về thông tin user
        return authResult;
      }
    }

    // Đăng nhập thất bại
    throw FirebaseAuthException(
        code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
        message: 'Missing Google Auth Token');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 50),
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'KitchenZ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                          fontSize: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        'Chào mừng lại đã trở lại.',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nhập email của bạn',
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
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nhập mật khẩu của bạn',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Icon(Icons.lock),
              ),
              style: TextStyle(fontSize: 17, height: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
                Text('Nhớ mật khẩu'),
                Spacer(),
                Text('Quên mật khẩu'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 22),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              child: Text('hoặc tiếp tục với', style: TextStyle(fontSize: 17, color: Colors.grey),),
            ),
          ),
          GestureDetector(
            onTap: () {
              signInWithGoogle().then((value) {
                // Xử lý khi đăng nhập thành công
              }).catchError((error) {
                // Xử lý khi đăng nhập thất bại
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(0xffF5F6F9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image(
                  width: 35,
                  height: 35,
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/74/65/f3/7465f30319191e2729668875e7a557f2.png'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Menu(title: '');
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }
                return Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () async{
                        final newuser = await _googleSignIn.signIn();
                        final googleauth = await newuser!.authentication;
                        final creds = GoogleAuthProvider.credential(
                            accessToken: googleauth.accessToken,
                            idToken: googleauth.idToken
                        );
                        await FirebaseAuth.instance.signInWithCredential(creds);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xffF5F6F9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image(
                          width: 35,
                          height: 35,
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/74/65/f3/7465f30319191e2729668875e7a557f2.png'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Row(
                children: [
                  Text(
                    'Không có tài khoản?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Tạo tài khoản?',
                    style: TextStyle(color: Colors.deepOrange),
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
