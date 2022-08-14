import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopwhey_app_2022/cart/cart.dart';
import 'package:shopwhey_app_2022/catalog/view/search_page.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/landings.dart';
import '../../constants/screen_sizes.dart';
import '../../screens/services/utils.dart';
import '../../screens/widgets/text_widget.dart';
import '../../search/view/search_page.dart';
import '../bloc/catalog_bloc.dart';
import '../models/item.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: getHeight(250),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.offerImages[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: Constss.offerImages.length,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red)),
              // control: const SwiperControl(color: Colors.black),
            ),
          ),
          // add data to firestore ( table: product)
          // IconButton(
          //     icon:const Icon(Icons.add_box_outlined),
          //     onPressed: ()=> Navigator.of(context).pushNamed("/add"),
          // ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_)=> const CartPage())),
          ),
          Container(
            height: getHeight(400),
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: 130,
                        child: Row(children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: Row(
                              children: [
                                TextWidget(
                                  text: 'Giảm Giá'.toUpperCase(),
                                  color: MyColors.primary,
                                  textSize: 22,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  IconlyLight.discount,
                                  color: MyColors.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: BlocBuilder<CatalogBloc, CatalogState>(
                              builder: (context, state) {
                                if (state is CatalogLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (state is CatalogLoaded) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.catalog.iteamS.length,
                                      itemBuilder: (context, index) {
                                        return CatalogListItem(
                                          state.catalog.getByPosition(index),
                                        );
                                      });
                                }
                                return const SliverFillRemaining(
                                  child: Text('Something went wrong!'),
                                );
                              },
                            ),
                          )
                        ])),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'Sản phẩm ',
                            color: MyColors.sub,
                            textSize: 22,
                            isTitle: true,
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:(_)=> SearchPage12()));
                              },
                              child: const Text(
                                "Tìm kiếm",
                                style: TextStyle(
                                    color: MyColors.sub,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              )),
                        ],
                      ),
                    ),
                    BlocBuilder<CatalogBloc, CatalogState>(
                      builder: (context, state) {
                        if (state is CatalogLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is CatalogLoaded) {
                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            padding: EdgeInsets.zero,
                            childAspectRatio: size.width / (size.height * 0.61),
                            children: List.generate(state.catalog.iteamS.length,
                                (index) {
                              return CatalogListItemProduct(
                                state.catalog.getByPosition(index),
                              );
                            }),
                          );
                        }
                        return const SliverFillRemaining(
                          child: Text('Something went wrong!'),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          final isInCart = state.cart.items.contains(item);
          return ElevatedButton(
              style: isInCart
                  ? ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.7),
                    )
                  : ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.7),
                    ),
              onPressed: () {
                if (!isInCart) {
                  return context.read<CartBloc>().add(CartItemAdded(item));
                } else {
                  return context.read<CartBloc>().add(CartItemRemoved(item));
                }
              },
              child: isInCart
                  ? const Text(
                      "Hủy",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      "Đặt ngay",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ));
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

class CatalogAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Catalog'),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.of(context).pushNamed('/cart'),
        ),
      ],
    );
  }
}

class CatalogListItem extends StatelessWidget {
  const CatalogListItem(this.item, {Key? key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: MyColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FancyShimmerImage(
                  imageUrl: item.imageUrl,
                  height: getHeight(70),
                  width: getWidth(70),
                  boxFit: BoxFit.fill,
                ),
                Column(
                  children: const [
                    Text(
                      "1KG",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(children: [
              Text(
                "${item.price}",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                "${item.salePrice}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough),
              ),
            ]),
            item.id.length < 14
                ? Text(
                    item.id,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  )
                : Text(
                    item.id,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  )
          ])),
    );
  }
}

class CatalogListItemProduct extends StatelessWidget {
  const CatalogListItemProduct(this.item, {Key? key}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
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
