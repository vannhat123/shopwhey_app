import 'package:flutter/material.dart';
import 'package:shopwhey_app_2022/catalog/shopping_repository.dart';

import '../models/item.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _State();
}

class _State extends State<Test> {
  Future<List<Item>>? itemList;
  late List<Item> getList =[];

  ShoppingRepository shoppingRepository = ShoppingRepository();


  Future<void> _initRetrieval() async {
    itemList = shoppingRepository.getItems();
    getList = await shoppingRepository.getItems();
  }

  @override
  Widget build(BuildContext context) {
    _initRetrieval();
    return Scaffold(
        backgroundColor: Colors.white12,
        body: FutureBuilder(
          future: itemList,
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            return ListView.builder(
                itemCount: getList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 70,
                    color: Colors.green,
                    //   child: Text("in thong tin ${shoppingRepository.getDocs()}",style: TextStyle(color:Colors.white),),
                    child: Text(
                      getList[index].id,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                });
          },
        ));
  }
}
