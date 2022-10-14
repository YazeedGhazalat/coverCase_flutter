import 'package:case_store/components/storeWidget.dart';
import 'package:case_store/screens/WelcomeScreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser; //this give us the email

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String screenRoute = "chatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final mssageTextcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText; //this give us the message

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        print(signInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();

  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection("messages").snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text("MessageMe"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (() {
                //  _auth.signOut();
                Navigator.pushReplacementNamed(
                    context, WelcomeScreen.screenRoute);
              }),
              icon: Icon(
                Icons.sign_language_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessageStreamBulder(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: mssageTextcontroller,
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              hintText: "Write your message here...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: (() {
                            mssageTextcontroller.clear();
                            _firestore.collection("stuff").add(
                              {
                                'url': messageText,
                                'price': signInUser.email,
                                'time': FieldValue.serverTimestamp(),
                              },
                            );
                          }),
                          child: Text(
                            "Send",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStreamBulder extends StatelessWidget {
  const MessageStreamBulder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("stuff").orderBy('time').snapshots(),
      builder: ((context, snapshot) {
        List<itemPicPrice> messageWidgets = [];
        if (!snapshot.hasData) {
          // add heere a spinner
          Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get("url");
          final messageSender = message.get("price");
          final messageTime = message.get('time');
          final currentUser = signInUser.email;

          final messageWidget = itemPicPrice(
            pricePic: messageSender.toString(),
            picURL: messageText.toString(),
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            children: messageWidgets,
          ),
        );
      }),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine(
      {super.key,
      this.text,
      required this.time,
      this.sender,
      required this.isME});
  final String? text;
  final String? sender;
  final bool isME;
  final String? time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text("$sender",
              style: TextStyle(fontSize: 12, color: Colors.yellow[900])),
          Material(
              elevation: 5,
              borderRadius: isME
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
              color: isME ? Colors.blue[800] : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                    style: TextStyle(
                      color: isME ? Colors.white : Colors.black54,
                      fontSize: 15,
                    ),
                    "$text ,  "),
              )),
        ],
      ),
    );
  }
}
