import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/category.dart';
import '../pages/deal.dart';
import '../pages/find.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _currentIndex = 0;
  final screens = [
    const HomePage(),
    const CategoryPage(),
    FindPage(),
    const DealPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Thể loại'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tìm'),
          BottomNavigationBarItem(icon: Icon(Icons.accessibility_new_rounded), label: 'Dinh dưỡng'),
        ],
      ),
    );
  }
}
