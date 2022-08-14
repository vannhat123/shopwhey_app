import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
 final String id;
 final String   title, imageUrl, productCategoryName;
 final double price, salePrice;
 final bool isOnSale, isPiece;

  Item({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isPiece,
  });

 Map<String, dynamic> toMap() {
   return {
     'id' : id,
     'title' : title,
     'price' : price,
     'salePrice': salePrice,
     'imageUrl' :imageUrl,
     'productCategoryName' : productCategoryName,
     'isOnSale': isOnSale,
     'isPiece': isPiece,
   };
 }

    Item.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
   : id = doc.data()!['id'],
    title = doc.data()!['title'],
    price = doc.data()!['price'],
    salePrice = doc.data()!['salePrice'],
    imageUrl = doc.data()!['imageUrl'],
    productCategoryName = doc.data()!['productCategoryName'],
    isOnSale = doc.data()!['isOnSale'],
    isPiece = doc.data()!['isPiece'];



  @override
  List<Object> get props => [
        id,
        title,
        price,
        salePrice,
        imageUrl,
        productCategoryName,
        isOnSale,
        isPiece
      ];
}

