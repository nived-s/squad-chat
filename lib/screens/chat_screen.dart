import 'package:flutter/material.dart';
import 'package:chat_app/utilities/constants.dart';
import 'package:chat_app/utilities/inputField_login_signup.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  late User loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      // ignore: await_only_futures
      final user = await _auth.currentUser!;
      loggedInUser = user;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void getMessagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(FontAwesomeIcons.xmark)),
        ],
        title: const Text("💬 Chat Room"),
        backgroundColor: lightestYellow,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('Timestamp').snapshots(),
              builder: (context, snapshot) {
                List<MessageBubble> messageWidgets = [];
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: orangishLogo),
                  );
                }
                final messages = snapshot.data?.docs.reversed.toList();
                for (var message in messages!) {
                  final messageText = message['text'];
                  final messageSender = message['sender'];
                  final currentUser = loggedInUser.email;
                  final messageWidget = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == messageSender,
                  );
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    children: messageWidgets,
                  ),
                );
              },
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: LoginAndSignupInput(
                      onChanged: (value) {
                        messageText = value;
                      },
                      icon: FontAwesomeIcons.textSlash,
                      hinttext: 'Type here...',
                      controller: messageController,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageController.clear();
                      //messageText+loggedInUser.email
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'Timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kInputStyles,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: kSenderText,
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
            elevation: 5,
            color: isMe ? orangishLogo : similarOrangishLogo,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: kMessageText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
