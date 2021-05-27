import 'package:afogata/chat/bloc/chat_bloc.dart';
import 'package:afogata/chat/chat_detail/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailScreen extends StatefulWidget {
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatChoosedState) {
        return Body(
          imageUrl: state.imageUser,
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
