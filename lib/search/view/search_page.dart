import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../catalog/bloc/catalog_bloc.dart';
import '../../catalog/models/item.dart';
import '../../catalog/shopping_repository.dart';
import '../../catalog/view/catalog_page.dart';
import '../../constants/colors.dart';
import '../../constants/screen_sizes.dart';
import '../../screens/services/utils.dart';

class SearchPage12 extends StatefulWidget {
  const SearchPage12({Key? key}) : super(key: key);

  @override
  State<SearchPage12> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage12> {
  TextEditingController editingController = TextEditingController();
  List<Item> listItem123 = [];
  Future<List<Item>>? itemList;
  ShoppingRepository shoppingRepository = ShoppingRepository();

  @override
  void initState() {
    _initRetrieval();
    super.initState();
  }

  Future<void> _initRetrieval() async {
    listItem123 = await shoppingRepository.loadCatalog();
    itemList = shoppingRepository.loadCatalog();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Tất cả sản phẩm',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: MyColors.primary.withOpacity(0.8),
          ),
          body: FutureBuilder(
            future: itemList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              return Column(
                children: [
                 Expanded(
                   child:  BlocBuilder<CatalogBloc, CatalogState>(
                     builder: (context, state) {
                       if (state is CatalogLoading) {
                         return const Center(child: CircularProgressIndicator());
                       }
                       if (state is CatalogLoaded) {
                         return Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(6.0),
                               child: SizedBox(
                                 height: getHeight(50),
                                 child: TextField(
                                   textAlignVertical: TextAlignVertical.center,
                                   textAlign: TextAlign.left,
                                   controller: editingController,
                                   onChanged: (value) {
                                     filterSearchResults(value,
                                         state.catalog.iteamS);
                                   },
                                   decoration: const InputDecoration(
                                       contentPadding: EdgeInsets.zero,
                                       hintText: "Tìm kiếm",
                                       prefixIcon:
                                       Icon(Icons.search),
                                       border: OutlineInputBorder(
                                           borderRadius:
                                           BorderRadius.all(
                                               Radius.circular(
                                                   25.0)))),
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Padding(
                                 padding:
                                 const EdgeInsets.only(left: 5, right: 5),
                                 child: SingleChildScrollView(
                                      child: Column(
                                         children: [
                                           GridView.count(
                                             shrinkWrap: true,
                                             physics:
                                             const NeverScrollableScrollPhysics(),
                                             crossAxisCount: 2,
                                             padding: EdgeInsets.zero,
                                             childAspectRatio: size.width /
                                                 (size.height * 0.61),
                                             children: List.generate(
                                                 state.catalog.iteamS.length,
                                                     (index) {
                                                   return CatalogListItemProduct(
                                                     state.catalog
                                                         .getByPosition(index),
                                                   );
                                                 }),
                                           )
                                         ],
                                       )
                                 ),
                               ),
                             ),
                             const SizedBox(
                               height: 8,
                             ),
                           ],
                         );
                       }
                       return const SliverFillRemaining(
                         child: Text('Something went wrong!'),
                       );
                     },
                   ),
                 ),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              );
            },
          )),
    );
  }

  void filterSearchResults(String query, List<Item> listItem) {
    if (query.isNotEmpty) {
      List<Item> dummyListData = [];
      listItem.forEach((item) {
        if (item.id.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        listItem.clear();
        listItem.addAll(dummyListData);
      });
      return;
    } else if (query.trim().isEmpty) {
      setState(() {
        listItem.clear();
        listItem.addAll(listItem123);
      });
      return;
    }
  }
}

class Detail extends StatelessWidget {
  Detail({Key? key, required this.user}) : super(key: key);
  Item user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown[400], title: const Text('Detail')),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.s,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User information',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Name: ${user.id}',
                  style: TextStyle(fontSize: 18),
                ),
              ]),
        ),
      ),
    );
  }
}

class CatalogListItemProduct extends StatelessWidget {
  const CatalogListItemProduct(this.item, {Key? key}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            FancyShimmerImage(
              imageUrl: item.imageUrl,
              height: getHeight(70),
              width: getWidth(70),
              boxFit: BoxFit.fill,
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                  text: TextSpan(
                      text: "${item.price}  ",
                      style: const TextStyle(color: Colors.green, fontSize: 13),
                      children: [
                    TextSpan(
                      text: "${item.salePrice}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough),
                    )
                  ])),
              const Icon(
                IconlyLight.heart,
                size: 18,
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                item.id.length < 14
                    ? Text(
                        item.id,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      )
                    : Text(
                        "${item.id.substring(0, 10)}...",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                const Text(
                  "1KG",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              height: 20,
              child: AddButton(item: item),
            )
          ])),
    );
  }
}
