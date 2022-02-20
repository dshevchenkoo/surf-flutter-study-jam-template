import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen_widget_model.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/message.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/nickname_app_bar.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/post_msg.dart';

/// Widget for demo.
class ChatScreen extends ElementaryWidget<IChatScreenWidgetModel> {
  const ChatScreen({
    Key? key,
    WidgetModelFactory wmFactory = chatScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IChatScreenWidgetModel wm) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: NicknameAppBar(
          wm: wm,
        ),
      ),
      bottomSheet: PostMsg(wm: wm),
      body: EntityStateNotifierBuilder<List<ChatMessageDto>>(
          listenableEntityState: wm.messagesState,
          loadingBuilder: (_, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          },
          builder: (_, List<ChatMessageDto>? data) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: ListView.builder(
                reverse: true,
                controller: wm.listViewController,
                dragStartBehavior: DragStartBehavior.down,
                itemCount: data!.length,
                itemBuilder: (_, index) {
                  final reversedIndex = data.length - 1 - index;

                  final ChatMessageDto currentMessage = data[reversedIndex];
                  final ChatUserDto currentUser = currentMessage.author;

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Message(
                      wm: wm,
                      currentMsg: currentMessage,
                      currentUser: currentUser,
                    ),
                  );
                },
              ),
            );
          },
          errorBuilder: (_, __, ___) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text('Произошла ошибка попробуйте обновить чат'),
                ),
              ],
            );
          }),
    );
  }
}
