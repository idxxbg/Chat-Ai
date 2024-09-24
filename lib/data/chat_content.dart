import 'package:equatable/equatable.dart';

enum Sender { user, gemini }

class ChatContent extends Equatable {
  final Sender sender;
  final String message;

  ChatContent.user(this.message) : sender = Sender.user;
  ChatContent.gemini(this.message) : sender = Sender.gemini;

  @override
  // TODO: implement props
  List<Object?> get props => [sender, message];
}
