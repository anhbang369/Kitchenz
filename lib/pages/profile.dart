import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/items/user_image.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Thông tin cá nhận'),
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
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                UserImage(onFileChanged: (imageUrl) {
                  setState(() {
                    this.imageUrl = imageUrl;
                    print('url của ảnh: ${imageUrl}');
                  });
                }),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText:
                          '${FirebaseAuth.instance.currentUser?.displayName ?? "Anonymous"}',
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập email của bạn',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: Icon(Icons.map),
                    ),
                    style: TextStyle(fontSize: 17, height: 2),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập email của bạn',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: Icon(Icons.phone),
                    ),
                    style: TextStyle(fontSize: 17, height: 2),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText:
                          '${FirebaseAuth.instance.currentUser?.email ?? "Anonymous"}',
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith((states) {
                          return Colors.deepOrange;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ),
      ),
    );
  }
}
