import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import '../models/deal_model.dart';
import '../items/deal_item.dart';

class DealPage extends StatefulWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Chế độ ăn'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius:
                    BorderRadius.circular(20), // Thêm border radius vào đây
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Thực đơn theo tuần',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          FutureBuilder<List<DealModel>>(
            future: ApiService.getRoutineList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DealModel> deals = snapshot.data as List<DealModel>;
                return Expanded(
                  child: ListView.builder(
                    itemCount: deals.length,
                    itemBuilder: (context, index) {
                      return DealItem(deals[index].id, deals[index].name);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
