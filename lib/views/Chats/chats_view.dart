import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';
import '../../widgets/chats/chat_item.dart';
import '../../widgets/view_header_item.dart';

class ChatsView extends StatefulWidget {
  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  List<Widget> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtility.midGrey,
        child: Icon(
          Icons.chat,
          color: ColorUtility.primary,
        ),
        onPressed: () {
          setState(() {
            chats.add(
              ChatItem(),
            );
          });
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ViewHeaderItem(
              title: 'Chats',
            ),
          ),
          Expanded(
            child: chats.isEmpty
                ? Center(
                    child: Text(
                      'Start Your Conversation',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: chats,
                  ),
          )
        ],
      ),
    );
  }
}
