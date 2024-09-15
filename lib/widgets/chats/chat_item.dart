import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/views/Chats/conversation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/preferences_services.dart';
import '../../utils/color_utility.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({super.key});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  String profileImageUrl = FirebaseAuth.instance.currentUser?.photoURL ?? '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      profileImageUrl =
          PreferencesServices.prefs?.getString('profileImageUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ConversationView.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: ColorUtility.secondary,
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl)
                          : const NetworkImage(
                        'https://th.bing.com/th/id/OIP.sUtuDAldRIExk4haK9HB1AAAAA?rs=1&pid=ImgDetMain',
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('messages')
                              .where('id', isEqualTo: FirebaseAuth.instance.currentUser?.email)
                              .orderBy('createdAt', descending: true)
                              .limit(1)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Text(
                                'No message',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: ColorUtility.kGrey,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }

                            var latestMessage = snapshot.data!.docs.first;
                            var messageText = latestMessage['message'] ?? 'No message';

                            return Text(
                              messageText,
                              style: TextStyle(
                                fontSize: 10,
                                color: ColorUtility.kGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          },
                        )

                      ],
                    ),
                  ],
                ),
                Text(
                  DateFormat('hh:mm a').format(DateTime.now()),
                  style: TextStyle(
                    color: ColorUtility.blueGray,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: ColorUtility.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
