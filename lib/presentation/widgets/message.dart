import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen_widget_model.dart';

class Message extends StatelessWidget {
  const Message(
      {Key? key,
      required this.currentUser,
      required this.currentMsg,
      required this.wm})
      : super(key: key);
  final ChatUserDto currentUser;
  final ChatMessageDto currentMsg;
  final IChatScreenWidgetModel wm;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.deepPurple,
          ),
          child: Center(
            child: Text(
              currentUser.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: wm.sizeWidth - 200,
                child: Text(
                  currentMsg.message,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
