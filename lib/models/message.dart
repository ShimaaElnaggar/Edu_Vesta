import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String message;

  Message({required this.id, required this.message});

  factory Message.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      id: data['id'] ?? '',
      message: data['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
    };
  }
}
