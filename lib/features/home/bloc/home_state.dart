part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoddingState extends HomeState {}

class HomeLoddedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoddedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeAddToCartActionState extends HomeActionState {}

class HomeAddToWishlistActionState extends HomeActionState {}
