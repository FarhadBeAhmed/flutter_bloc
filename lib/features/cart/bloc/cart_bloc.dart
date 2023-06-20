import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learn/data/cart_items.dart';
import 'package:flutter_bloc_learn/features/home/models/home_product_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(initialEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
  }

  FutureOr<void> initialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoddedSuccessState(cartItems: cartItems.toList()));
  }

  FutureOr<void> removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartLoddedSuccessState(cartItems: cartItems.toList()));
  }
}
