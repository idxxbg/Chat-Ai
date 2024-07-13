import 'package:flutter/material.dart';
import 'package:public_chat/widgets/chat_bubble_widget.dart';
import 'package:public_chat/widgets/message_box_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                child: ListView(
                  children: [
                    ChatBubble(
                      isMine: true,
                      photoUrl: 'https://i.imgur.com/cefjdCQ.jpeg',
                      message:
                          'https://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJ',
                    ),
                    ChatBubble(
                      isMine: false,
                      photoUrl: 'https://i.imgur.com/cefjdCQ.jpeg',
                      message:
                          'https://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJhttps://youtu.be/3_Hvy6GyQJ4?si=qAw5VtKwjqgG0sPJ',
                    ),
                  ],
                ),
              ),
              MessageBox(),
            ],
          ),
        ),
      ),
    );
  }
}
