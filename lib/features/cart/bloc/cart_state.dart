part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoddedSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartLoddedSuccessState({required this.cartItems});
}
