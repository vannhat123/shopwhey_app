import 'package:equatable/equatable.dart';

import 'models.dart';

// class Catalog extends Equatable {
//   Catalog(this.imageUrl, this.productCategoryName, this.price, this.salePrice,
//       this.isOnSale, this.isPiece,this.title);
//
//   final List<String> title;
//   final List<String> imageUrl;
//   final List<String> productCategoryName;
//   final List<double> price;
//   final List<double> salePrice;
//   final List<bool> isOnSale;
//   final List<bool> isPiece;
//
//   Item getById(int id) => Item(
//         id: id.toString(),
//         title: title[id % title.length],
//         imageUrl: imageUrl[id % title.length],
//         productCategoryName: productCategoryName[id % title.length],
//         price: price[id % title.length],
//         salePrice: salePrice[id % title.length],
//         isOnSale: isOnSale[id % title.length],
//         isPiece: isPiece[id % title.length],
//       );
//
//   Item getByPosition(int position) => getById(position);
//
//   @override
//   List<Object> get props => [
//         title,
//         imageUrl,
//         productCategoryName,
//         price,
//         salePrice,
//         isOnSale,
//         isPiece
//       ];
// }

class Catalog extends Equatable {
  Catalog({required this.iteamS});

  final List<Item> iteamS;


  Item getById(int idNumber) => Item(
     id: iteamS[idNumber % iteamS.length].id,
    title:  iteamS[idNumber % iteamS.length].title,
    price:  iteamS[idNumber % iteamS.length].price,
    salePrice:  iteamS[idNumber % iteamS.length].salePrice,
    imageUrl:  iteamS[idNumber % iteamS.length].imageUrl,
    productCategoryName:  iteamS[idNumber % iteamS.length].productCategoryName,
    isOnSale:  iteamS[idNumber % iteamS.length].isOnSale,
    isPiece:  iteamS[idNumber % iteamS.length].isPiece);

     Item getByPosition(int position) => getById(position);

  @override
  List<Object> get props => [iteamS];
}
