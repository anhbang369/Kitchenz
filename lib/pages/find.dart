import 'package:firstapp/models/ingredient_model.dart';
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
                onTap: () {},
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
            ],
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
