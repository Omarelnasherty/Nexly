// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:chat_app/models/messages.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final ScrollController _controller = ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Chat',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 31, 33, 62),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return chatbubble(
                          message: messagesList[index],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add(
                        {
                          'message': value,
                          'createdAt': DateTime.now(),
                          'id': email
                        },
                      );
                      controller.clear();

                      _controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.send),
                      iconColor: Color.fromARGB(255, 31, 33, 62),
                      hintText: 'send message',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 31, 33, 62)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('loading');
        }
      },
    );
  }
}
