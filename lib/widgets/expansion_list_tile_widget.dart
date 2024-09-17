import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';

class ExpansionListTile extends StatefulWidget {
  final String title;
  final Widget child;
  const ExpansionListTile({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  State<ExpansionListTile> createState() => _ExpansionListTileState();
}

class _ExpansionListTileState extends State<ExpansionListTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isExpanded ? Colors.white : ColorUtility.midGrey,
            borderRadius: BorderRadius.circular(8),
            border: isExpanded
                ? Border.all(
                    color: ColorUtility.secondary,
                  )
                : const Border.symmetric(
                    vertical: BorderSide.none, horizontal: BorderSide.none),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  isExpanded
                      ? Icons.keyboard_double_arrow_down
                      : Icons.keyboard_double_arrow_right,
                  color: isExpanded ? ColorUtility.secondary : Colors.black,
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: widget.child,
          ),
      ],
    );
  }
}
