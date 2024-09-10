
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
