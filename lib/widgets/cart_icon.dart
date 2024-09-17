
import 'package:edu_vesta/views/Cart/cart_view.dart';
import 'package:flutter/material.dart';


class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pushNamed(context, CartView.id);
        },
        icon:  const Icon(Icons.shopping_cart_outlined,size: 27,),
    );
  }
}
