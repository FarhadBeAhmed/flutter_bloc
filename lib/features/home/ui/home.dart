import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/data/cart_items.dart';
import 'package:flutter_bloc_learn/data/wishlist_items.dart';
import 'package:flutter_bloc_learn/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_learn/features/wishlist/ui/wishlist.dart';

import '../../cart/ui/cart.dart';
import '../bloc/home_bloc.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int wishlistBadgeCount = 0;
  int cartBadgeCount = cartItems.length;

  @override
  void initState() {
    super.initState();
    cartBadgeCount = cartItems.length;
    homeBloc.add(HomeInitialEvent());
  }

//   @override
//   Widget build(BuildContext context) {
//     return  WillPopScope(
//       onWillPop: _onWillPop,
//       child:  Scaffold(
//         appBar:  AppBar(
//           title:  Text("Home Page"),
//         ),
//         body:  Center(
//           child: new Text("Home Page"),
//         ),
//       ),
//     );
//   }
// }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          // TODO: implement listener
          if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ));
          }
          if (state is HomeNavigateToWishlistPageActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wishlist(),
                ));
          }
          if (state is HomeAddToWishlistActionState) {
            wishlistBadgeCount = wishlistItems.length;
            setState(() {});
          }
          if (state is HomeAddToCartActionState) {
            cartBadgeCount = cartItems.length;
            setState(() {});
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoddingState:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );

            case HomeLoddedSuccessState:
              final successState = state as HomeLoddedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  actions: [
                    badges.Badge(
                      badgeAnimation:
                          const badges.BadgeAnimation.fade(toAnimate: false),
                      showBadge: wishlistBadgeCount == 0 ? false : true,
                      position: badges.BadgePosition.topEnd(top: 5, end: 5),
                      badgeContent: Text(
                        wishlistBadgeCount.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                          onPressed: () {
                            homeBloc.add(HomeWishlistButtonNavigateEvent());
                          },
                          icon: const Icon(Icons.favorite_border)),
                    ),
                    badges.Badge(
                      badgeAnimation:
                          const badges.BadgeAnimation.fade(toAnimate: false),
                      showBadge: cartBadgeCount == 0 ? false : true,
                      position: badges.BadgePosition.topEnd(top: 5, end: 5),
                      badgeContent: Text(
                        cartBadgeCount.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                          onPressed: () {
                            homeBloc.add(HomeCartButtonNavigateEvent());
                          },
                          icon: const Icon(Icons.shopping_bag_outlined)),
                    )
                  ],
                  title: const Center(child: Text('Home Grocery')),
                ),
                body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                      );
                    }),
              );

            case HomeErrorState:
              return Scaffold(
                body: Container(
                    child: const Center(child: Text("data Not Found"))),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
