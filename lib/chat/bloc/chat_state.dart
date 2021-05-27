part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatsLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatsLoaded({required this.messages});
  @override
  List<Object> get props => [messages];
}

class ChatChoosedState extends ChatState {
  final String imageUser;

  ChatChoosedState({required this.imageUser});

  @override
  List<Object> get props => [imageUser];
}
