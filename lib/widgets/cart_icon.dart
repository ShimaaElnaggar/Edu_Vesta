
import 'package:flutter/material.dart';


class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){},
        icon:  const Icon(Icons.shopping_cart_outlined,size: 27,),
    );
  }
}
