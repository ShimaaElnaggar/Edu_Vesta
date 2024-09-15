import 'package:edu_vesta/widgets/categories_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/view_header_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ViewHeaderItem(
            title: 'Search',
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Trending',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          CategoriesWidget(),
        ]),
      ),
    );
  }
}
