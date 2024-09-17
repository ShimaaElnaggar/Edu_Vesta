import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/course.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  List<Course> _cartItems = [];

  CartBloc(super.initialState);

  CartState get initialState => CartLoaded(_cartItems);

  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      _cartItems.add(event.course);
      yield CartLoaded(List.from(_cartItems));
    }





  }
}
