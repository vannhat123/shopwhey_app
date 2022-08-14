import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopwhey_app_2022/cart/view/cart_nofifi_page.dart';
import 'package:shopwhey_app_2022/catalog/shopping_repository.dart';
import 'package:shopwhey_app_2022/screens/profile/profile.dart';

import '../../../constants/constants.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../catalog/bloc/catalog_bloc.dart';
import '../../catalog/view/catalog_page.dart';
import '../../search/bloc/search_bloc.dart';
import '../categories/categories.dart';

//Bloc = Redux Saga(React)
class AppTab extends StatefulWidget {
  const AppTab({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: AppTab());

  @override
  _AppTabState createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
   final ShoppingRepository shoppingRepository = ShoppingRepository();

  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': const Icon(Icons.home),
      'title': "Catalog Page",
    },
    {
      'icon': const Icon(Icons.add_chart_sharp),
      'title': "Categories screen",
    },
    {
      'icon': const Icon(Icons.shopping_cart),
      "title": "cart notification screen",
    },
    {
      'icon': const Icon(Icons.account_circle_rounded),
      'title': "profile screen",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CatalogBloc(
            shoppingRepository: shoppingRepository,
          )..add(CatalogStarted()),
        ),
        BlocProvider(
          create: (_) => CartBloc(
            shoppingRepository: shoppingRepository,
          )..add(CartStarted()),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            shoppingRepository: shoppingRepository,
          )..add(SearchStarted()),
        ),
      ],
        child: MaterialApp(
        home: DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            bottomNavigationBar: Container(
              color: MyColors.primary.withOpacity(0.8),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(5.0),
                indicatorColor: Colors.white,
                tabs: _tabs
                    .map((eachTab) => Tab(
                  icon: eachTab['icon'],
                ))
                    .toList(),
              ),
            ),
            body: TabBarView(
                children:
                [
                  CatalogPage(),
                  CategoriesScreen(),
                  const CartNotifiPage(),
                  const Profile(),
                ]
            ),
          ),
        )
    ));
  }
}
