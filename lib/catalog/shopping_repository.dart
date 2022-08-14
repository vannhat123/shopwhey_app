import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/item.dart';

const _delay = Duration(milliseconds: 800);

class ShoppingRepository {
  final _items = <Item>[];
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Item>> getItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("product").get();
    return snapshot.docs
        .map((docSnapshot) => Item.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Item>> loadCatalog() => Future.delayed(_delay, () => getItems());

  Future<List<Item>> loadCartItems() => Future.delayed(_delay, () => _items);

  void addItemToCart(Item item) => _items.add(item);

  void removeItemFromCart(Item item) => _items.remove(item);

}
