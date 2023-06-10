import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/dish_model.dart';
import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/pages/payment.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import '../items/view_detail_nutrition_item.dart';
import '../items/view_detail_ingredient_item.dart';
import '../items/view_detail_step_item.dart';
import '../pages/comment.dart';

class ViewDetail extends StatefulWidget {
  const ViewDetail({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  UserModel? currentUser;
  @override
  void initState() {
    ApiService.getCurrentUser().then((user) {
      setState(() {
        currentUser = user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DishModel>(
        future: ApiService.fetchDishDetail(widget.id),
        builder: (context, snapshot) {
          // Check if user is null
          if (currentUser == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            // Check if dish is vip or not
            if (snapshot.data?.isVip == true && currentUser!.isVip == false) {
              // Show dialog to buy vip package
              return AlertDialog(
                title: const Text('Vip Package'),
                content: const Text('Buy vip package to view this dish'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Payment())),
                    child: const Text('Buy'),
                  ),
                ],
              );
            }
            return buildDishDetail(context, snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget buildDishDetail(BuildContext context, DishModel dish) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Center(
                child: Text(
              dish.name,
              style: const TextStyle(fontSize: 25),
            )),
          ),
        ),
        pinned: true,
        backgroundColor: Colors.orangeAccent,
        expandedHeight: 350,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            dish.imageUrl,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                dish.description,
                // ignore: prefer_const_constructors
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 0.7,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: dish.nutritionDishs.map((item) {
                  return ViewDetailNutritionItem(item.id, item.nutrition.name,
                      item.amount, item.nutrition.unit);
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Các nguyên liệu cần có',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Column(
              children: dish.ingredientDishs.map((item) {
                return ViewDetailIngredientItem(item.id, item.ingredient.name,
                    item.amount, item.ingredient.unit);
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Các bước hướng dẫn',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                  children: List.generate(dish.steps.length, (index) {
                return ViewDetailStepItem(
                  dish.steps[index].id,
                  (index + 1).toString(),
                  dish.steps[index].script,
                );
              })),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Comment(
                              dishId: dish.id,
                              comments: dish.comments,
                            )),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
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
  );
}

// const NUTRITION_DATA = [
//   ViewDetailNutritionModel(id: '1', title: 'Chất béo', amount: 20),
//   ViewDetailNutritionModel(id: '1', title: 'Chất béo', amount: 20),
//   ViewDetailNutritionModel(id: '1', title: 'Chất béo', amount: 20),
// ];
// const INGREDIENT_DATA = [
//   ViewDetailIngredientModel(id: '1', title: 'Xương ống bò', amount: '20gam'),
//   ViewDetailIngredientModel(id: '1', title: 'Bánh phở', amount: '20gam'),
//   ViewDetailIngredientModel(id: '1', title: 'Bò viên', amount: '20gam'),
//   ViewDetailIngredientModel(
//       id: '1', title: 'Hành tím, hành là, hành tây', amount: '20gam'),
//   ViewDetailIngredientModel(id: '1', title: 'Chanh, rừng', amount: '20gam'),
//   ViewDetailIngredientModel(
//       id: '1', title: 'Đinh hương, hoa hồi, thảo quả', amount: '20gam'),
// ];
// const STEP_DATA = [
//   ViewDetailStepModel(
//       id: '1',
//       title: 'Bước 1',
//       script:
//           'Ngâm xương ống với nước muối và giấm khoảng 2 tiếng cho sạch và bớt mùi tanh. Sau đó đem xương đi rửa sạch rồi cho vào nồi nước sôi cùng với gừng và 1 muỗng canh muối đun trong khoảng 10 phút thì vớt ra, trần qua nước lạnh.'),
//   ViewDetailStepModel(
//       id: '2',
//       title: 'Bước 2',
//       script:
//           'Ngâm xương ống với nước muối và giấm khoảng 2 tiếng cho sạch và bớt mùi tanh. Sau đó đem xương đi rửa sạch rồi cho vào nồi nước sôi cùng'),
//   ViewDetailStepModel(
//       id: '3',
//       title: 'Bước 3',
//       script:
//           ' Sau đó đem xương đi rửa sạch rồi cho vào nồi nước sôi cùng với gừng và 1 muỗng canh muối đun trong khoảng 10 phút thì vớt ra, trần qua nước lạnh.')
// ];
