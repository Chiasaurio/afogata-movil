import 'dart:async';

import 'package:afogata/chat/models/chatmessage_model.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiRepositoryImpl apiRepositoryImpl = ApiRepositoryImpl();

  ChatBloc() : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatInitEvent) {
      yield* _mapChatInitEventoState();
    }
    if (event is ChatChoosedEvent) {
      yield ChatChoosedState(imageUser: event.imageUrl);
    }
  }

  Stream<ChatState> _mapChatInitEventoState() async* {
    // final messages = await apiRepositoryImpl.getUserMessages();
    // if (token != null) {
    //   await apiRepositoryImpl.logout(token);
    // }
    // await localRepositoryImpl.clearAllData();
    // yield Unauthenticated();
  }
}
