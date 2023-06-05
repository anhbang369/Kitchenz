import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/dish_model.dart';
import 'package:firstapp/models/ingredient_model.dart';
import 'package:firstapp/pages/view_detail.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  int inputCount = 1;
  List<IngredientModel?> selectedIngredientList = [];
  List<IngredientModel> ingredientList = [];
  List<DishModel> foundedDishList = [];

  Future<void> loadData() async {
    await ApiService.fetchIngredientList().then((value) {
      setState(() {
        ingredientList = value;
      });
    });
  }

  void removeTextField(int index) {
    setState(() {
      selectedIngredientList.removeAt(index);
      inputCount--;
    });
  }

  @override
  void initState() {
    selectedIngredientList.add(null);
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tìm theo nguyên liệu'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: inputCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: buildIngredientSelect(index),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  if (inputCount < 4) {
                    // kiểm tra giá trị biến đếm
                    setState(() {
                      selectedIngredientList.add(null);
                      inputCount++; // tăng biến đếm lên một đơn vị sau khi thêm input mới
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Số lượng đã đạt tối đa",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16);
                  }
                },
                child: Center(
                  child: Container(
                    width: 310,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Thêm nguyên liệu",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // Make id list from selected ingredient list
                  List<int> idList = [];
                  for (var ingredient in selectedIngredientList) {
                    if (ingredient != null) {
                      idList.add(ingredient.id);
                    }
                  }
                  // Call api
                  ApiService.getDishByIngredientId(idList).then((value) {
                    debugPrint(value.toString());
                    setState(() {
                      foundedDishList = value;
                    });
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Container(
                      width: 330,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Tìm công thức",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: foundedDishList.length,
                  itemBuilder: (context, index) {
                    return buildDishItem(context, foundedDishList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card buildDishItem(BuildContext context, DishModel dish) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewDetail(id: dish.id)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 365,
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 108,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(dish.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 195,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          dish.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('${dish.duration.ceil()} phút'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          dish.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                FirebaseAuth.instance.currentUser?.uid ==
                        'BKJq8xaAnHhIhe8AnUEmLPpraqo1'
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 80),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {},
                          splashRadius: 1,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: IconButton(
                          icon: Icon(
                            true ? Icons.favorite : Icons.favorite_border,
                            color: true ? Colors.red : Colors.black,
                          ),
                          onPressed: () {},
                          splashRadius: 1,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildIngredientSelect(int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<IngredientModel?>(
              isExpanded: true,
              hint: const Text('Chọn nguyên liệu'),
              value: selectedIngredientList[index],
              items: ingredientList.map((value) {
                // Skip value if it is already selected

                return DropdownMenuItem<IngredientModel?>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedIngredientList[index] = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        index != 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    removeTextField(index);
                  });
                },
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFF6B74D6),
                    size: 35,
                  ),
                  onPressed: () {
                    if (selectedIngredientList.length > 1) {
                      removeTextField(index);
                    }
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
