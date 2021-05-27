import 'package:afogata/chat/chat_list_screen.dart/components/conversation_list.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatUserScreen extends StatefulWidget {
  ChatUserScreen({Key? key}) : super(key: key);

  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL:
            "https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=381&q=80",
        time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL:
            "https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=330&q=80",
        time: "Yesterday"),
    // ChatUsers(
    //     name: "Jorge Henry",
    //     messageText: "Hey where are you?",
    //     imageURL: "images/userImage3.jpeg",
    //     time: "31 Mar"),
    // ChatUsers(
    //     name: "Philip Fox",
    //     messageText: "Busy! Call me in 20 mins",
    //     imageURL: "images/userImage4.jpeg",
    //     time: "28 Mar"),
    // ChatUsers(
    //     name: "Debra Hawkins",
    //     messageText: "Thankyou, It's awesome",
    //     imageURL: "images/userImage5.jpeg",
    //     time: "23 Mar"),
    // ChatUsers(
    //     name: "Jacob Pena",
    //     messageText: "will update you in evening",
    //     imageURL: "images/userImage6.jpeg",
    //     time: "17 Mar"),
    // ChatUsers(
    //     name: "Andrey Jones",
    //     messageText: "Can you please share the file?",
    //     imageURL: "images/userImage7.jpeg",
    //     time: "24 Feb"),
    // ChatUsers(
    //     name: "John Wick",
    //     messageText: "How are you?",
    //     imageURL: "images/userImage8.jpeg",
    //     time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Mensajes",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ]))),
          ListView.builder(
            itemCount: chatUsers.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ConversationList(
                name: chatUsers[index].name,
                messageText: chatUsers[index].messageText,
                imageUrl: chatUsers[index].imageURL,
                time: chatUsers[index].time,
                isMessageRead: (index == 0 || index == 3) ? true : false,
              );
            },
          ),
        ],
      )),
    );
  }
}
