import 'package:flutter/material.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class NutritionInfo {
  String nutrition;
  String nutritionAmount;

  NutritionInfo({required this.nutrition, required this.nutritionAmount});
}

class IngredientInfo {
  String ingredient;
  String ingredientAmount;

  IngredientInfo({required this.ingredient, required this.ingredientAmount});
}

class StepInfo {
  String stepBy;
  String stepAmount;

  StepInfo({required this.stepBy, required this.stepAmount});
}

class _CreateRecipeState extends State<CreateRecipe> {
  int _activeStepIndex = 0;

  TextEditingController title = TextEditingController();
  TextEditingController script = TextEditingController();
  TextEditingController nutrition = TextEditingController();
  TextEditingController nutritionAmount = TextEditingController();
  TextEditingController ingredient = TextEditingController();
  TextEditingController ingredientAmount = TextEditingController();
  TextEditingController stepbystep = TextEditingController();
  TextEditingController stepbystepScript = TextEditingController();

  List<NutritionInfo> nutritionList = [];
  List<IngredientInfo> ingredientList = [];
  List<StepInfo> stepByList = [];

  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text(''),
            content: Column(
              children: [
                const Text(
                  'Tạo mới công thức',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sáng tạo thêm nhiều công thức để mang lại nhiều trải nghiệm cho người dùng tại đây. Đây là nơi thỏa xuất cho bạn sáng tạo những công thức độc đáo, mới lạ.',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Nhập tên công thức',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  style: const TextStyle(fontSize: 17, height: 2),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextFormField(
                    controller: script,
                    minLines: 2,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Viết một cái gì đó...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Tải ảnh lên',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            )),
        Step(
          state: _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text(''),
          content: Column(
            children: [
              const Text(
                'Giá trị dinh dưỡng',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Có bao nhiêu ca lo trong món ăn của bạn? Có bao nhiêu gam chất béo có trong bánh?',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nutrition,
                decoration: InputDecoration(
                  hintText: 'Nhập chất dinh dưỡng',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: const TextStyle(fontSize: 17, height: 2),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nutritionAmount,
                decoration: InputDecoration(
                  hintText: 'Số lượng ex: 100 cal',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: const TextStyle(fontSize: 17, height: 2),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Lưu thông tin chất dinh dưỡng vào danh sách
                    String _nutrition = nutrition.text;
                    String _nutritionAmount = nutritionAmount.text;
                    NutritionInfo nutritionInfo = NutritionInfo(
                      nutrition: _nutrition,
                      nutritionAmount: _nutritionAmount,
                    );
                    nutritionList.add(nutritionInfo);

                    // Xóa nội dung của TextField sau khi lưu giá trị
                    nutrition.clear();
                    nutritionAmount.clear();
                    //load
                    setState(() {});
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
                      'Thêm chất dinh dưỡng',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: nutritionList.length,
                itemBuilder: (context, index) {
                  NutritionInfo nutritionInfo = nutritionList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Thay đổi giá trị border radius tùy ý
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F6FA),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    nutritionInfo.nutrition,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    nutritionInfo.nutritionAmount,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      removeNutritionInfo(
                                          index); // index là vị trí của phần tử trong danh sách
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color(0xFF6B74D6),
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Step(
          state: _activeStepIndex <= 2 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text(''),
          content: Column(
            children: [
              const Text(
                'Những nguyên liệu cần có',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bổ xung các nguyên trọng tâm cho món ăn của bạn. Kèm theo số lượng của vât liệu cần thiết để món ăn của bạn trở nên tuyệt vời hơn.',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ingredient,
                decoration: InputDecoration(
                  hintText: 'Nhập nguyên liệu',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: const TextStyle(fontSize: 17, height: 2),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ingredientAmount,
                decoration: InputDecoration(
                  hintText: 'Số lượng ex: 100 gam',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: const TextStyle(fontSize: 17, height: 2),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Lưu thông tin chất dinh dưỡng vào danh sách
                    String _ingredient = ingredient.text;
                    String _ingredientAmount = ingredientAmount.text;
                    IngredientInfo ingredientInfo = IngredientInfo(
                      ingredient: _ingredient,
                      ingredientAmount: _ingredientAmount,
                    );
                    ingredientList.add(ingredientInfo);

                    // Xóa nội dung của TextField sau khi lưu giá trị
                    ingredient.clear();
                    ingredientAmount.clear();
                    //load
                    setState(() {});
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
                      'Thêm nguyên liệu',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ingredientList.length,
                itemBuilder: (context, index) {
                  IngredientInfo ingredientInfo = ingredientList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Thay đổi giá trị border radius tùy ý
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F6FA),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    ingredientInfo.ingredient,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    ingredientInfo.ingredientAmount,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      removeIngredientInfo(
                                          index); // index là vị trí của phần tử trong danh sách
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color(0xFF6B74D6),
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 3,
          title: const Text(''),
          content: Column(
            children: [
              const Text(
                'Các bước nấu ăn',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Đây là bước cuối cùng giúp món ăn bạn hướng dẫn đến người nấu theo công thức. Hãy ghi cẫn thận từng bước và lựa chọn câu từ phù hợp để người làm dễ dàng hình dung.',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: stepbystep,
                decoration: InputDecoration(
                  hintText: 'Nhập bước',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: const TextStyle(fontSize: 17, height: 2),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextFormField(
                  controller: stepbystepScript,
                  minLines: 2,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Nhập mô tả của bước...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Lưu thông tin chất dinh dưỡng vào danh sách
                    String _stepBy = stepbystep.text;
                    String _stepByScript = stepbystepScript.text;
                    StepInfo stepByInfo = StepInfo(
                      stepBy: _stepBy,
                      stepAmount: _stepByScript,
                    );
                    stepByList.add(stepByInfo);

                    // Xóa nội dung của TextField sau khi lưu giá trị
                    stepbystep.clear();
                    stepbystepScript.clear();

                    //load
                    setState(() {});
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
                      'Thêm nguyên liệu',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: stepByList.length,
                itemBuilder: (context, index) {
                  StepInfo stepByInfo = stepByList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffC4C4C4),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    stepByInfo.stepBy,
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    removeStepByStepInfo(
                                        index); // index là vị trí của phần tử trong danh sách
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              stepByInfo.stepAmount,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              stepByList.isNotEmpty
                  ? SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
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
                        child: Center(
                          child: TextButton(
                            child: const Text(
                              'Tạo món',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              debugPrint(title.text);
                              debugPrint(script.text);
                            },
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tạo món'),
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
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            _activeStepIndex += 1;
          }
          setState(() {});
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          _activeStepIndex -= 1;
          setState(() {});
        },
      ),
    );
  }

  void removeNutritionInfo(int index) {
    setState(() {
      nutritionList.removeAt(index);
    });
  }

  void removeIngredientInfo(int index) {
    setState(() {
      ingredientList.removeAt(index);
    });
  }

  void removeStepByStepInfo(int index) {
    setState(() {
      stepByList.removeAt(index);
    });
  }
}
