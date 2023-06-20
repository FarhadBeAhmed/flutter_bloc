import 'package:flutter/material.dart';
import 'package:flutter_bloc_learn/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_learn/features/home/models/home_product_model.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: productDataModel.image != null
                    ? DecorationImage(
                        image: NetworkImage('${productDataModel.image}'),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: NetworkImage(
                            'https://colorlib.com/wp/wp-content/uploads/sites/2/404-error-page-templates.jpg'),
                      ),
              )),
          const SizedBox(height: 20),
          Text('${productDataModel.name}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ${productDataModel.price}'),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeProductWishlistButtonClickEvent(
                        //     productDataModel: productDataModel));
                      },
                      icon: const Icon(Icons.favorite_border_outlined)),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(RemoveFromCartEvent(
                            productDataModel: productDataModel));
                      },
                      icon: const Icon(Icons.remove_circle_outline_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
