import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_learn/features/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Center(child: Text('Cart page')),
      ),
      body: BlocConsumer(
        bloc: cartBloc,
        buildWhen: (previouse, current) => current is! CartActionState,
        listenWhen: (previouse, current) => current is CartActionState,
        listener: (context, state) {
          if (state is CartLoddedSuccessState) {
            setState(() {});
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoddedSuccessState:
              final successState = state as CartLoddedSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        productDataModel: successState.cartItems[index],
                        cartBloc: cartBloc);
                  });

            default:
          }
          return const Center(
            child: Text(
              'No Data Found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
