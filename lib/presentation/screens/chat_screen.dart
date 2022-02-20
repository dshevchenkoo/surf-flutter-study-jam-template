import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen_widget_model.dart';

/// Widget for demo.
class ChatScreen extends ElementaryWidget<IChatScreenWidgetModel> {
  const ChatScreen({
    Key? key,
    WidgetModelFactory wmFactory = chatScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IChatScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: IconButton(
              onPressed: () => wm.updateMsg(),
              icon: const Icon(Icons.refresh),
            ),
          )
        ],
        title: TextFormField(
          controller: wm.nickNameController,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите ник',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              )),
        ),
      ),
      bottomSheet: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: wm.msgController,
                  decoration: InputDecoration(
                    hintText: 'Сообщение',
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () => wm.sendMsg(),
                icon: Icon(Icons.send),
              )
            ],
          ),
        ),
      ),
      body: EntityStateNotifierBuilder<List<ChatMessageDto>>(
        listenableEntityState: wm.messagesState,
        loadingBuilder: (_, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        },
        builder: (_, List<ChatMessageDto>? data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              controller: wm.listViewController,
              dragStartBehavior: DragStartBehavior.down,
              itemCount: data!.length,
              itemBuilder: (_, index) {
                final ChatMessageDto currentMessage = data[index];
                final ChatUserDto currentUser = currentMessage.author;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
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
                      Column(
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
                              currentMessage.message,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
