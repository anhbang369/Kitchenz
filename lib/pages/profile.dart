import 'package:firstapp/items/user_image.dart';
import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = '';
  UserModel? currentUser;
  String username = '';
  String phone = '';
  String address = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Thông tin cá nhận'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: FutureBuilder(
            future: ApiService.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                currentUser = snapshot.data;
                return ListView(
                  children: [
                    UserImage(
                        imgeUrl: currentUser?.imageUrl,
                        onFileChanged: (imageUrl) {
                          setState(() {
                            this.imageUrl = imageUrl;
                          });
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: TextField(
                        onChanged: (value) => username = value,
                        decoration: InputDecoration(
                          hintText: currentUser!.username == ''
                              ? 'Nhập tên của bạn'
                              : currentUser!.username,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: const Icon(Icons.person),
                        ),
                        style: const TextStyle(fontSize: 17, height: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: TextField(
                        onChanged: (value) => address = value,
                        decoration: InputDecoration(
                          hintText: currentUser!.address == ''
                              ? 'Nhập địa chỉ của bạn'
                              : currentUser!.address,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: const Icon(Icons.map),
                        ),
                        style: const TextStyle(fontSize: 17, height: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: TextField(
                        onChanged: (value) => phone = value,
                        decoration: InputDecoration(
                          hintText: currentUser!.phone == ''
                              ? 'Nhập số điện thoại của bạn'
                              : currentUser!.phone,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: const Icon(Icons.phone),
                        ),
                        style: const TextStyle(fontSize: 17, height: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: TextField(
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          hintText: currentUser!.email,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: const Icon(Icons.mail),
                        ),
                        style: const TextStyle(fontSize: 17, height: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate phone number if it is not empty
                            if (phone != '') {
                              // Clean phone number white space
                              phone = phone.replaceAll(' ', '');
                              if (phone.length != 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Số điện thoại phải có 10 chữ số'),
                                  ),
                                );
                                return;
                              }
                            }
                            // Validate email
                            if (email != '') {
                              if (!email.contains('@')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Email không hợp lệ'),
                                  ),
                                );
                                return;
                              }
                            }
                            debugPrint('username: $username');
                            debugPrint('phone: $phone');
                            debugPrint('address: $address');
                            debugPrint('email: $email');
                            ApiService.updateUser(
                                    username, email, address, phone, imageUrl)
                                .then((value) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Cập nhật thành công'),
                                        ),
                                      ),
                                    });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateColor.resolveWith((states) {
                              return Colors.deepOrange;
                            }),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Cập nhật',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
