import 'package:flutter/material.dart';
import '../models/view_detail_nutrition_model.dart';
import '../items/view_detail_nutrition_item.dart';
import '../models/view_detail_ingredient_model.dart';
import '../items/view_detail_ingredient_item.dart';
import '../models/view_detail_step_model.dart';
import '../items/view_detail_step_item.dart';
import '../pages/comment.dart';

class ViewDetail extends StatelessWidget {
  const ViewDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: Text(
                  'Sliver app bar testing',
                  style: TextStyle(fontSize: 25),
                )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.orangeAccent,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://ameovat.com/wp-content/uploads/2016/05/cach-lam-com-chien-duong-chau-600x481.jpg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: Text(
                    'here are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which dont look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isnt anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
                    style: TextStyle(fontSize: 20),
                  ),
                  margin: EdgeInsets.only(left: 20, right: 20),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3/0.7,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    children: NURITION_DATA
                        .map((item) => ViewDetailNutritionItem(item.id, item.title, item.amount))
                        .toList(),
                  ),
                ),
                Container(
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Các nguyên liệu cần có', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ),
                ),
                Container(
                  child: Column(
                    children: INGREDIENT_DATA
                        .map((item) => ViewDetailIngredientItem(item.id, item.title, item.amount))
                        .toList(),
                  ),
                ),
                Container(
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Các bước hướng dẫn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    children: STEP_DATA
                        .map((item) => ViewDetailStepItem(item.id, item.title, item.script))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Comment()),
                      );
                    },
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                          child: Text(
                            'Xem các bình luận',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const NURITION_DATA = [
  ViewDetailNutritionModel(id: '1', title: 'Chất béo', amount: 20),
  ViewDetailNutritionModel(id: '1', title: 'Chất béo', amount: 20),
  ViewDetailNutritionModel(id: '1', title: 'Chất béo', amount: 20),
];
const INGREDIENT_DATA = [
  ViewDetailIngredientModel(id: '1', title: 'Xương ống bò', amount: '20gam'),
  ViewDetailIngredientModel(id: '1', title: 'Bánh phở', amount: '20gam'),
  ViewDetailIngredientModel(id: '1', title: 'Bò viên', amount: '20gam'),
  ViewDetailIngredientModel(id: '1', title: 'Hành tím, hành là, hành tây', amount: '20gam'),
  ViewDetailIngredientModel(id: '1', title: 'Chanh, rừng', amount: '20gam'),
  ViewDetailIngredientModel(id: '1', title: 'Đinh hương, hoa hồi, thảo quả', amount: '20gam'),
];
const STEP_DATA = [
  ViewDetailStepModel(id: '1', title: 'Bước 1', script: 'Ngâm xương ống với nước muối và giấm khoảng 2 tiếng cho sạch và bớt mùi tanh. Sau đó đem xương đi rửa sạch rồi cho vào nồi nước sôi cùng với gừng và 1 muỗng canh muối đun trong khoảng 10 phút thì vớt ra, trần qua nước lạnh.'),
  ViewDetailStepModel(id: '2', title: 'Bước 2', script: 'Ngâm xương ống với nước muối và giấm khoảng 2 tiếng cho sạch và bớt mùi tanh. Sau đó đem xương đi rửa sạch rồi cho vào nồi nước sôi cùng'),
  ViewDetailStepModel(id: '3', title: 'Bước 3', script: ' Sau đó đem xương đi rửa sạch rồi cho vào nồi nước sôi cùng với gừng và 1 muỗng canh muối đun trong khoảng 10 phút thì vớt ra, trần qua nước lạnh.')
  ];


