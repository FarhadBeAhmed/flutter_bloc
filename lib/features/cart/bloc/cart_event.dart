part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class RemoveFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;

  RemoveFromCartEvent({required this.productDataModel});
}
