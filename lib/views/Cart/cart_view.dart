
import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/courses/courses_data.dart';
import '../../widgets/custom_expansionl_panel_list.dart';

class CartView extends StatelessWidget {
  static const id = 'cart_view';
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height:20),
            Container(
              height: 100,
              child: Column(
                children: [
                  HeaderWidget(
                      title: 'Cart',
                  ),
                ],
              ),
            ),
           Expanded(child: CustomExpansionPanelList()),
          ],
        ),
      ),
    );
  }
}
