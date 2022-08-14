// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import '../../constants/colors.dart';
// import '../../constants/screen_sizes.dart';
// import '../../screens/services/utils.dart';
// import '../bloc/catalog_bloc.dart';
// import '../models/item.dart';
// import 'catalog_page.dart';
//
// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Utils utils = Utils(context);
//     Size size = utils.getScreenSize;
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               title: const Text(
//                 'Tất cả sản phẩm',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold),
//               ),
//               backgroundColor: MyColors.primary.withOpacity(0.8),
//             ),
//             body: Column(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: getHeight(50),
//                       child: TextField(
//                         onChanged: null,
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 const BorderSide(color: Colors.green, width: 1),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 const BorderSide(color: Colors.green, width: 1),
//                           ),
//                           hintText: "Bạn đang tìm gì",
//                           prefixIcon: const Icon(Icons.search),
//                           suffix: IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.close,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 5, right: 5),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           BlocBuilder<CatalogBloc, CatalogState>(
//                             builder: (context, state) {
//                               if (state is CatalogLoading) {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               }
//                               if (state is CatalogLoaded) {
//                                 return GridView.count(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   crossAxisCount: 2,
//                                   padding: EdgeInsets.zero,
//                                   childAspectRatio:
//                                       size.width / (size.height * 0.61),
//                                   children: List.generate(
//                                       state.catalog.iteamS.length, (index) {
//                                     return CatalogListItemProduct(
//                                       state.catalog.getByPosition(index),
//                                     );
//                                   }),
//                                 );
//                               }
//                               return const SliverFillRemaining(
//                                 child: Text('Something went wrong!'),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//               ],
//             )));
//   }
// }
//
// class CatalogListItemProduct extends StatelessWidget {
//   const CatalogListItemProduct(this.item, {Key? key}) : super(key: key);
//   final Item item;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(3),
//       decoration: BoxDecoration(
//         color: MyColors.primary.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Padding(
//           padding:
//               const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             FancyShimmerImage(
//               imageUrl: item.imageUrl,
//               height: getHeight(70),
//               width: getWidth(70),
//               boxFit: BoxFit.fill,
//             ),
//             const SizedBox(height: 5),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               RichText(
//                   text: TextSpan(
//                       text: "${item.price}  ",
//                       style: const TextStyle(color: Colors.green, fontSize: 13),
//                       children: [
//                     TextSpan(
//                       text: "${item.salePrice}",
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 11,
//                           decoration: TextDecoration.lineThrough),
//                     )
//                   ])),
//               const Icon(
//                 IconlyLight.heart,
//                 size: 18,
//               ),
//             ]),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 item.id.length < 14
//                     ? Text(
//                         item.id,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Colors.black),
//                       )
//                     : Text(
//                         "${item.id.substring(0, 10)}...",
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Colors.black),
//                         softWrap: false,
//                         maxLines: 1,
//                         overflow: TextOverflow.fade,
//                       ),
//                 const Text(
//                   "1KG",
//                   style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 )
//               ],
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 25),
//               height: 20,
//               child: AddButton(item: item),
//             )
//           ])),
//     );
//   }
// }
