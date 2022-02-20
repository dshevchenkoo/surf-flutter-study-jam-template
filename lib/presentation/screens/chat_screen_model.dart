import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/firebase.dart';

class ChatScreenModel extends ElementaryModel {
  ChatScreenModel(ErrorHandler errorHandler)
      : super(errorHandler: errorHandler) {
    chatRepository = ChatRepositoryFirebase(FirebaseFirestore.instance);
  }

  late ChatRepository chatRepository;
  List<ChatMessageDto> messages = [];

  loadMessages() async {
    messages = await chatRepository.messages;
  }

  sendMsg({
    required String msg,
    required String username,
  }) async {
    messages = await chatRepository.sendMessage(username, msg);
  }
}
