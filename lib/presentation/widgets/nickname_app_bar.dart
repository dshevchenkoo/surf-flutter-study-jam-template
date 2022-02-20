import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen_widget_model.dart';

class NicknameAppBar extends StatelessWidget {
  const NicknameAppBar({Key? key, required this.wm}) : super(key: key);
  final IChatScreenWidgetModel wm;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
          ),
          child: InkWell(
            onTap: () => wm.updateMsg(),
            child: Container(
              width: 50,
              height: 50,
              child: RiveAnimation.asset(
                'assets/rive/2.riv',
                controllers: [wm.riveUpdateController],
                onInit: (_) {},
              ),
            ),
          ),

          // IconButton(
          //   onPressed: () => wm.updateMsg(),
          //   icon: const Icon(Icons.refresh),
          // ),
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
          ),
        ),
      ),
    );
  }
}
