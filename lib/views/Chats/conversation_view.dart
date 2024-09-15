
import 'package:edu_vesta/widgets/arrow_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message.dart';
import '../../services/preferences_services.dart';
import '../../utils/color_utility.dart';
import '../../widgets/chats/chat_buble.dart';

class ConversationView extends StatefulWidget {
  static const id = 'ConversationView';


  const ConversationView({Key? key}) : super(key: key);

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  final _controller = ScrollController();

  final CollectionReference messages =
  FirebaseFirestore.instance.collection('messages');

  final TextEditingController controller = TextEditingController();
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
    final email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('CreatedAt', descending: true).snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasError) {
          return Center(child: Text('Error: ${snapshots.error}'));
        }
        if (snapshots.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }if(!snapshots.hasData){
          return const Text('No data available right now');
        }
        debugPrint('=== data ===: ${snapshots.data!.docs.toString()}');
        List<Message> messagesList = [];
        for (int i = 0; i < snapshots.data!.docs.length; i++) {
          messagesList.add(Message.fromJson(snapshots.data!.docs[i] ));
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  ArrowBack(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorUtility.secondary,
                    backgroundImage: profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : const NetworkImage(
                      'https://th.bing.com/th/id/OIP.sUtuDAldRIExk4haK9HB1AAAAA?rs=1&pid=ImgDetMain',
                    ),
                  ),
                   SizedBox(width: 5,),
                   Text(  FirebaseAuth.instance.currentUser?.displayName ?? ''),
                ],
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email ?  ChatBuble(
                        message: messagesList[index],
                      ) : ChatBubleForFriend(message: messagesList[index]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    color: ColorUtility.lightGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add(
                          {'message': data, 'CreatedAt': DateTime.now(), 'id' : email },

                        );
                        controller.clear();
                        _controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Type Message...',
                        suffixIcon: const Icon(
                          Icons.send,
                          color: ColorUtility.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}