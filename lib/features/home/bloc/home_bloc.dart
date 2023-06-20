import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learn/data/cart_items.dart';
import 'package:flutter_bloc_learn/data/grocery_data.dart';
import 'package:flutter_bloc_learn/data/wishlist_items.dart';
import 'package:flutter_bloc_learn/features/home/models/home_product_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishlistButtonClickEvent>(
        homeProductWishlistButtonClickEvent);
    on<HomeProductCartButtonClickEvent>(homeProductCartButtonClickEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoddingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoddedSuccessState(
        products: GroceryData.groceryList
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                price: e['price'],
                image: e['image']))
            .toList()));
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('wishlist Navigate Button clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('cart Navigate Button clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickEvent(
      HomeProductWishlistButtonClickEvent event, Emitter<HomeState> emit) {
    wishlistItems.add(event.productDataModel);
    print('wishlist Button clicked');
    emit(HomeAddToWishlistActionState());
  }

  FutureOr<void> homeProductCartButtonClickEvent(
      HomeProductCartButtonClickEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.productDataModel);
    emit(HomeAddToCartActionState());
    print('cart Button clicked');
  }
}
