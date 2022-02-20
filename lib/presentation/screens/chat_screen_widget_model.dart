import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen_model.dart';

ChatScreenWidgetModel chatScreenWidgetModelFactory(BuildContext context) {
  final errorHandler = context.read<ErrorHandler>();
  return ChatScreenWidgetModel(ChatScreenModel(errorHandler));
}

/// WidgetModel for [TestPageWidget]
class ChatScreenWidgetModel extends WidgetModel<ChatScreen, ChatScreenModel>
    implements IChatScreenWidgetModel {
  late EntityStateNotifier<List<ChatMessageDto>> _messagesController;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _listViewController = ScrollController();
  SimpleAnimation _riveUpdateController = SimpleAnimation('idle');
  ChatScreenWidgetModel(ChatScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _messagesController = EntityStateNotifier();
    loadMessages();
  }

  @override
  void dispose() {
    _controller.dispose();
    _listViewController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  @override
  get nickNameController => _controller;

  @override
  get sizeWidth => MediaQuery.of(context).size.width;

  @override
  get msgController => _msgController;

  @override
  ListenableState<EntityState<List<ChatMessageDto>>> get messagesState =>
      _messagesController;

  Future<void> loadMessages() async {
    _messagesController.loading();
    await model.loadMessages();

    _messagesController.content(model.messages);
  }

  @override
  sendMsg() async {
    try {
      await model.sendMsg(msg: _msgController.text, username: _controller.text);
      _msgController.clear();
      _messagesController.content(model.messages);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Произошла ошибка при отправке сообщения"),
      ));
    }
  }

  @override
  get listViewController => _listViewController;

  @override
  updateMsg() async {
    _riveUpdateController = SimpleAnimation('active');
    try {
      _messagesController.loading();
      await model.loadMessages();
      _messagesController.content(model.messages);
      _riveUpdateController = SimpleAnimation('idle');
    } catch (e) {
      _messagesController
          .error(Exception('Произошла ошибка попробуйте обновить чат'));
    }
  }

  @override
  get riveController => SimpleAnimation('active');

  @override
  get riveUpdateController => _riveUpdateController;
}

abstract class IChatScreenWidgetModel extends IWidgetModel {
  get nickNameController;
  get sizeWidth;
  get msgController;

  get listViewController;

  get riveController;

  get riveUpdateController;
  updateMsg();

  ListenableState<EntityState<List<ChatMessageDto>>> get messagesState;

  sendMsg();
}
