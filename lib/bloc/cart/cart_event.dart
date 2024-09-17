part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}
class AddToCart extends CartEvent {
  final Course course;

  AddToCart(this.course);
}

class RemoveFromCart extends CartEvent {
  final Course course;
  RemoveFromCart(this.course);
}
