    import 'package:flutter/material.dart';
    import 'package:chatty/constants.dart';
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:firebase_auth/firebase_auth.dart';


    final _fireStore = FirebaseFirestore.instance;
    User? loggedInUser;

    class ChatScreen extends StatefulWidget {
       final String recieverEmail;
      static const String id = 'chat_screen';

  const ChatScreen({super.key, required this.recieverEmail});

      @override
      _ChatScreenState createState() => _ChatScreenState();
    }

    class _ChatScreenState extends State<ChatScreen> {


      final messageTextController = TextEditingController();
      late String messageText;
      final _auth = FirebaseAuth.instance;


     @override
      void initState() {
        getCurrentUser();
        super.initState();

      }
      void getCurrentUser()async {
        try {
          final user = await _auth.currentUser;
          if (user != null) {
            loggedInUser = user;
          }
        } catch (e) {
          print(e);
        }
      }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.recieverEmail),
            backgroundColor: Colors.teal,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
           MessagesStream(recieverEmail: widget.recieverEmail),
            SizedBox(height: 5),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(

                          controller: messageTextController,
                          onChanged: (value) {
                          messageText =value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.brown,
                          onPressed: () {
                                if (loggedInUser != null) {
                                _fireStore.collection('messages').add({
                                'text': messageText,
                                'sender': loggedInUser!.email,
                                'receiver': widget.recieverEmail,
                                'timestamp': FieldValue.serverTimestamp(),
                                'participants': [loggedInUser!.email, widget.recieverEmail],
                                });
                                } else {
                                print("User is not logged in");
                                // You can show a snackbar or some other UI to inform the user
                                }
                                messageTextController.clear();
                                },

                          child: Icon(Icons.send),
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
      const MessageBubble({super.key, required this.sender, required this.text, required this.isMe});

      final String sender;
      final String text;
      final bool isMe;

      @override
      Widget build(BuildContext context) {
        return Padding(
          padding:  EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: isMe?CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text('$sender',style: TextStyle(
                  fontSize: 12,
                  color: Colors.white),),
              Material(
                borderRadius: BorderRadius.only(topLeft: isMe? Radius.circular(30) : Radius.circular(0),bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30), topRight: isMe? Radius.circular(0) : Radius.circular(30)),
                elevation: 5.0,
                color: isMe? Colors.teal : Colors.brown,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical:10,horizontal:  20),
                  child: Text('$text',style: TextStyle(color: isMe? Colors.white : Colors.white),
                      ),
                ),
              ),
            ],
          ),
        );
      }
    }

  class MessagesStream extends StatelessWidget {
  final String recieverEmail;
  MessagesStream({super.key, required this.recieverEmail});
  final _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('timestamp',descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];

          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final messageReceiver = message['receiver'];


            final currentUser = loggedInUser?.email;
            if ((messageSender == currentUser && messageReceiver == recieverEmail) ||
    (messageSender == recieverEmail && messageReceiver == currentUser)) {




    final messageBubble = MessageBubble(sender: messageSender, text: messageText,isMe: currentUser == messageSender);
            messageBubbles.add(messageBubble);
            }
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              children: messageBubbles,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
      },
    );
  }
}
