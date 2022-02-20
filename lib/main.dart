import 'package:elementary/elementary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/firebase_options.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(
      androidKey: 'AIzaSyAgleMBLWGeOQHnGpAyCMDsxoz4CdK46Fg',
      iosKey: 'AIzaSyCn005OVun4NhDkvTpjhNjhTvAQPUPgGHU',
      webKey: 'AIzaSyAtMxD7Nb6Z06IL2yg8DbI56xoneVhXSNQ',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: Provider<ErrorHandler>(
        create: (_) => ChatErrorHandler(),
        child: ChatScreen(),
      ),
    );
  }
}

class ChatErrorHandler implements ErrorHandler {
  @override
  void handleError(Object error) {
    if (kDebugMode) {
      print(error);
    }
  }
}
