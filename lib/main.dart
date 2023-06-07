import 'package:firstapp/service/api_service.dart';
import 'package:firstapp/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/sign_up.dart';
import 'package:firstapp/pages/menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firstapp/pages/forget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51N1idNG02NFclnWKxxHOYTXvVFnW2a0OHAyU8U0cX4e21KHcwptaypZ7KDgRa2qe0ElmnQtYGGNbH6Fsc49hgKCt008MfDb74U";
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Check if the user is logged in

        home: FutureBuilder(
          future: ApiService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return const Menu(title: '');
            } else {
              return LoginIn();
            }
          },
        ));
  }
}

class LoginIn extends StatefulWidget {
  LoginIn({Key? key}) : super(key: key);

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  String? mtoken = " ";
  /*@override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    // Initialization tasks can be performed here
    // For example, initializing variables or fetching data
  }*/
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _rememberMe = false;
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100, bottom: 50),
            child: SizedBox(
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
                    padding: EdgeInsets.only(top: 10),
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
              controller: _emailEditingController,
              decoration: InputDecoration(
                hintText: 'Nhập email của bạn',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: const Icon(Icons.mail),
              ),
              style: const TextStyle(fontSize: 17, height: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextField(
              controller: _passwordEditingController,
              decoration: InputDecoration(
                hintText: 'Nhập mật khẩu của bạn',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: const Icon(Icons.lock),
              ),
              style: const TextStyle(fontSize: 17, height: 2),
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
                const Text('Nhớ mật khẩu'),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FogetPassword()),
                    );
                  },
                  child: const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: signUpButton(context, false
                // , () {
                //   FirebaseAuth.instance
                //       .signInWithEmailAndPassword(
                //           email: _emailEditingController.text,
                //           password: _passwordEditingController.text)
                //       .then((value) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const Menu(title: '')));
                //   }).catchError((e) {
                //     Fluttertoast.showToast(
                //         msg: "Vui lòng kiểm tra lại email và mật khẩu.",
                //         toastLength: Toast.LENGTH_LONG,
                //         gravity: ToastGravity.BOTTOM,
                //         timeInSecForIosWeb: 1,
                //         backgroundColor: Colors.grey,
                //         textColor: Colors.white,
                //         fontSize: 16.0);
                //   });
                // }
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              child: const Text(
                'hoặc tiếp tục với',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ),
          ),
          /*StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
                return Container();*/
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      final newuser = await _googleSignIn.signIn();
                      final googleauth = await newuser!.authentication;
                      final creds = GoogleAuthProvider.credential(
                          accessToken: googleauth.accessToken,
                          idToken: googleauth.idToken);
                      await FirebaseAuth.instance.signInWithCredential(creds);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
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
                ),
              );
            },
          ),*/
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseService().signInWithGoogle();
                if (FirebaseAuth.instance.currentUser != null) {
                  ApiService.login(FirebaseAuth.instance.currentUser!.email!,
                          FirebaseAuth.instance.currentUser!.uid)
                      .then((user) {
                    FirebaseService().signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Menu(title: '')));
                  });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Menu(title: '')));
                } else {
                  // Yêu cầu người dùng đăng nhập trước khi chuyển đến trang chủ
                  // ...
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  return Colors.white;
                }),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F6F9),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Image(
                    width: 35,
                    height: 35,
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/74/65/f3/7465f30319191e2729668875e7a557f2.png'),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Không có tài khoản?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      // Xử lý sự kiện chuyển sang trang SignUp ở đây
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text(
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

  Widget signUpButton(BuildContext context, bool isLogin) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          ApiService.login(
            _emailEditingController.text,
            _passwordEditingController.text,
          ).then((user) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Menu(title: '')));
          }).catchError((e) {
            Fluttertoast.showToast(
              msg: "Vui lòng kiểm tra lại email và mật khẩu.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          });
        },
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
        child: const Center(
          child: Text(
            'Đăng nhập',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  /*void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings =  await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permisson');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    }else{
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
        (token) {
          setState(() {
            mtoken = token;
            print('My token is $mtoken');
          });
          saveToken(token!);
        }
    );
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserToken").doc("User2").set({
      'token': token,
    });
  }*/
}
