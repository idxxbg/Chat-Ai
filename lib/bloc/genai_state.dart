part of 'genai_bloc.dart';

@immutable
sealed class GenaiState extends Equatable {
  const GenaiState();
}

final class GenaiInitial extends GenaiState {
  @override
  List<Object> get props => [];
}

class MessageUpdate extends GenaiState {
  final List<ChatContent> contents;

  const MessageUpdate(this.contents);
  @override
  List<Object> get props => [...contents, contents.length];
}
