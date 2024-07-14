import 'package:flutter/material.dart';
import 'package:public_chat/widgets/chat_bubble_widget.dart';
import 'package:public_chat/widgets/message_box_widget.dart';
import 'package:public_chat/worker/genai_worker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GenAiWorker _work = GenAiWorker();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<ChatContent>>(
                    stream: _work.stream,
                    builder: (context, snapshot) {
                      final List<ChatContent> data = snapshot.data ?? [];
                      return ListView(
                        controller: _scrollController,
                        children: data.map((e) {
                          final bool isMine = e.sender == Sender.user;
                          return ChatBubble(
                              photoUrl: null,
                              message: e.message,
                              isMine: isMine);
                        }).toList(),
                      );
                    }),
              ),
              MessageBox(
                onSendMessage: (value) {
                  // const apiKey = String.fromEnvironment('apiKey');
                  _work.sendToGemini(value);

                  // print('chat: $apiKey');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
