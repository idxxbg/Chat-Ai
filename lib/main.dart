import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat/bloc/genai_bloc.dart';
import 'package:public_chat/data/chat_content.dart';
import 'package:public_chat/widgets/chat_bubble_widget.dart';
import 'package:public_chat/widgets/message_box_widget.dart';
import 'package:public_chat/worker/genai_worker.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => GenaiBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GenAiWorker _work = GenAiWorker();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    // if (_scrollController.hasClients) {
    //   _scrollController.animateTo(
    //     _scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeOut,
    //   );
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
                child: BlocBuilder<GenaiBloc, GenaiState>(
                  builder: (context, state) {
                    final List<ChatContent> data = [];
                    if (state is MessageUpdate) {
                      data.addAll(state.contents);
                      return ListView(
                        controller: _scrollController,
                        children: data.map((e) {
                          final bool isMine = e.sender == Sender.user;
                          int _messageCount = 0;
                          return ChatBubble(
                              heroTag: 'message_${_messageCount++}',
                              photoUrl: null,
                              message: e.message,
                              isMine: isMine);
                        }).toList(),
                      );
                    }
                    return ListView(
                      children: [Text("data")],
                    );
                  },
                ),
              ),
              MessageBox(
                onSendMessage: (value) {
                  _scrollToBottom();
                  // _work.sendToGemini(value, _scrollToBottom);
                  context.read<GenaiBloc>().add(SendMessageEvent(value));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
