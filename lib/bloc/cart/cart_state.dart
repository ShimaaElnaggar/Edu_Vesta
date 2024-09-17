part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Course> cartItems;

  CartLoaded(this.cartItems);
}


