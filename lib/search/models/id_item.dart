class IdItem{
  final String uid;
  IdItem({required this.uid});
}
class IdItemData{
  final String uid,id;
  final String   title, imageUrl, productCategoryName;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  IdItemData({
    required this.uid,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isPiece,
  });
}

