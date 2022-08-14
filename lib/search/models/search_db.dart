import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopwhey_app_2022/search/models/id_item.dart';
import 'package:shopwhey_app_2022/search/models/the_item.dart';


class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  //Firestore change FirebaseFirestore
  final CollectionReference demoCollection =
  FirebaseFirestore.instance.collection('product');


  // TheUserData from snapshot
  IdItemData _theUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return IdItemData(
      uid: uid,
        id: snapshot.get('id'),
        title: snapshot.get('title'),
        imageUrl: snapshot.get('imageUrl'),
        productCategoryName: snapshot.get('productCategoryName'),
        price: snapshot.get('price'),
      salePrice: snapshot.get('salePrice'),
      isOnSale: snapshot.get('isOnSale'),
      isPiece: snapshot.get('isPiece'),
    );
  }

  Stream<IdItemData> get userData {
    return demoCollection.doc(uid).snapshots().map(_theUserDataFromSnapshot);
  }
}

class DataList {
  final CollectionReference demoCollection =
  FirebaseFirestore.instance.collection('product');
  // Demo list from snapshot
  List<TheItem> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return TheItem(
        id: e.get('id')?? '',
        title: e.get('title')?? '',
        imageUrl: e.get('imageUrl')?? '',
        productCategoryName: e.get('productCategoryName')?? '',
        price: e.get('price')?? '',
        salePrice: e.get('salePrice')?? '',
        isOnSale: e.get('isOnSale')?? '',
        isPiece: e.get('isPiece')?? '',
      );
    }).toList();
  }

  Stream<List<TheItem>> get listUser {
    return demoCollection.snapshots().map(_userListFromSnapshot);
  }
}