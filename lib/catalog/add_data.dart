import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';
import 'package:shopwhey_app_2022/models/models.dart';
import 'package:shopwhey_app_2022/providers/products_provider_repository.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  List<ProductModel> _producModel = [];
  final CollectionReference profileAdd =
      FirebaseFirestore.instance.collection("product");

  @override
  void initState() {
    super.initState();
    ProductsProviderRepository.instance.getProducModel(x: 1).then((value) {
      setState(() {
        _producModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference profileAdd =
        FirebaseFirestore.instance.collection("product");
    return SafeArea(
        child: Scaffold(
            body: Container(
                color: Colors.indigo,
                child: Column(
                  children: [
                    Container(height: 100, width: 100, color: Colors.green),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                                child: const Text(
                                  "Add data",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                onTap: () async {
                                  for (int index = 0; index < _producModel.length; index++) {
                                    print("bat dau in");
                                    await profileAdd.doc("$index").set({
                                      'id': _producModel[index].id,
                                      'title': _producModel[index].title,
                                      'price': _producModel[index].price,
                                      'salePrice': _producModel[index].salePrice,
                                      'imageUrl': _producModel[index].imageUrl,
                                      'productCategoryName': _producModel[index].productCategoryName,
                                      'isOnSale': _producModel[index].isOnSale,
                                      'isPiece': _producModel[index].isPiece,
                                    });
                                    print('dang in $index');
                                  }
                                });
                          }),
                    ),
                  ],
                ))));
  }
}
