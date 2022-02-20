import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen_widget_model.dart';

class PostMsg extends StatelessWidget {
  const PostMsg({Key? key, required this.wm}) : super(key: key);
  final IChatScreenWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<List<ChatMessageDto>>(
      listenableEntityState: wm.messagesState,
      loadingBuilder: (_, __) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: wm.msgController,
                    decoration: const InputDecoration(
                      hintText: 'Сообщение',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.send,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
      builder: (_, List<ChatMessageDto>? data) {
        return Container(
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: wm.msgController,
                    decoration: const InputDecoration(
                      hintText: 'Сообщение',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () => wm.sendMsg(),
                  child: Container(
                    width: 50,
                    height: 50,
                    child: RiveAnimation.asset(
                      'assets/rive/1.riv',
                      controllers: [wm.riveController],
                      onInit: (_) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
