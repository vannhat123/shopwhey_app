import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';

import '../../catalog/models/item.dart';
import '../../constants/colors.dart';
import '../bloc/cart_bloc.dart';

class CartNotifiPage extends StatelessWidget {
  const CartNotifiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Đơn hàng',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: MyColors.primary.withOpacity(0.8),
      ),
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CartList(),
              ),
            ),
            const Divider(height: 4, color: MyColors.primary),
            CartTotal()
          ],
        ),
      ),
    );
  }
}



class CartList extends StatelessWidget {
  const CartList({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return ListView.separated(
            itemCount: state.cart.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final item = state.cart.items[index];
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.green,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Image.network(item.imageUrl,height: 35,),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.id,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                        ],
                      ),
                    ),),
                  const SizedBox(width:10, ),
                  Expanded(
                    flex: 2,
                    child: CancelButton(item: item),)
                ],
              );
            },
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key, required this.item}) : super(key: key);
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
          return SizedBox(
              height: 40,
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.7),
                  ),
                  onPressed: () {
                    if (isInCart) {
                      return context.read<CartBloc>().add(CartItemRemoved(item));
                    } else {
                      return;
                    }
                  },
                  child: isInCart
                      ? const Text(
                    "Hủy",
                    style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  )
                      : const Text(
                    "Đặt ngay",
                    style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ))
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

class CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hugeStyle =
    Theme.of(context).textTheme.headline1?.copyWith(fontSize: 48);

    return SizedBox(
      height: getHeight(200),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state is CartLoading) {
                return const CircularProgressIndicator();
              }
              if (state is CartLoaded) {
                return Text('\$${state.cart.totalPrice.toStringAsFixed(1)}', style: hugeStyle);
              }
              return const Text('Something went wrong!');
            }),
            const SizedBox(width: 24),
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')),
                  );
                },
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
