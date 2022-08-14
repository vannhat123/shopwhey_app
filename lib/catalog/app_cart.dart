// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopwhey_app_2022/cart/view/cart_nofifi_page.dart';
// import 'package:shopwhey_app_2022/catalog/shopping_repository.dart';
// import 'package:shopwhey_app_2022/catalog/view/catalog_page.dart';
// import 'package:shopwhey_app_2022/catalog/view/search_page.dart';
//
// import '../cart/bloc/cart_bloc.dart';
// import '../cart/view/cart_page.dart';
// import '../search/bloc/search_bloc.dart';
// import 'add_data.dart';
// import 'bloc/catalog_bloc.dart';
//
// class AppCart extends StatelessWidget {
//   const AppCart({Key? key, required this.shoppingRepository, required this.rourte}) : super(key: key);
//
//   final ShoppingRepository shoppingRepository;
//   final String rourte;
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => CatalogBloc(
//             shoppingRepository: shoppingRepository,
//           )..add(CatalogStarted()),
//         ),
//         BlocProvider(
//           create: (_) => CartBloc(
//             shoppingRepository: shoppingRepository,
//           )..add(CartStarted()),
//         ),
//         BlocProvider(
//           create: (_) => SearchBloc(
//             shoppingRepository: shoppingRepository,
//           )..add(SearchStarted()),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Bloc Shopping Cart',
//         initialRoute: rourte,
//         routes: {
//           '/': (_) => CatalogPage(),
//           '/cart': (_) => const CartPage(),
//           "/add": (_)=> const AddData(),
//           '/carnotifi': (_)=>  CartNotifiPage(),
//         },
//       ),
//     );
//   }
// }
