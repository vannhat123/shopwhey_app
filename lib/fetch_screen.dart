import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopwhey_app_2022/screens/bottombarscreen.dart';

import 'app/bloc/app_bloc.dart';
import 'constants/constants.dart';
import 'providers/providers.dart';


class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  static Page page()=> const MaterialPage<void>(child: FetchScreen());
  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.authImagesPaths;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      final User? user = authInstance.currentUser;
      if (user == null) {
        await productsProvider.fetchProducts();
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
      } else {
        await productsProvider.fetchProducts();
        await cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
      }
         await Navigator.push(context, MaterialPageRoute(builder:(_)=>  BottomBarScreen()),
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (ctx) => const BottomBarScreen(),)
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.red.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context){
  //   return  Scaffold(
  //     body: Center(
  //      child:  ElevatedButton(
  //        style: ButtonStyle(
  //          backgroundColor:
  //          MaterialStateProperty.resolveWith<Color>(
  //                (Set<MaterialState> states) {
  //              if (states.contains(MaterialState.hovered)) {
  //                return Colors.green;
  //              }
  //              return MyColors.primary.withOpacity(
  //                  0.5); // Use the component's default.
  //            },
  //          ),
  //        ),
  //        onPressed: () {
  //          context.read<AppBloc>().add(AppLogoutRequested());
  //        },
  //        child: const Text(
  //          "Thoát",
  //          style: TextStyle(color: Colors.white, fontSize: 20),
  //        ),
  //      )
  //     ),
  //   );
  // }
}

class Test1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello Bottom" , style: TextStyle(fontSize:50, color:Colors.red),),
      ),
    );
  }
}

