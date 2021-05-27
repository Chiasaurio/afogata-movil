part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatInitEvent extends ChatEvent {}

class ChatChoosedEvent extends ChatEvent {
  final String imageUrl;

  ChatChoosedEvent({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
