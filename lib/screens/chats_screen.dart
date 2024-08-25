import 'package:chatty/components/user_tile.dart';
import 'package:chatty/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:chatty/firebase_services.dart';

import 'newchat_screen.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final ChatServices _chatServices = ChatServices();

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  static const String id = 'chats_screen';

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewChatScreen()),
              );
            },
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatServices.getUsersStream(), // Ensure this returns a QuerySnapshot stream
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Check if snapshot has data
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No users found');
        }

        // Extract data and build a list of widgets
        final List<DocumentSnapshot> users = snapshot.data!.docs;

        return ListView(
          children: users.map((userDoc) {
            // Extract data from each document
            Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            return _buildUserListItem(userData, context); // Correctly call the function
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData['email'],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(recieverEmail: userData['email']),
          ),
        );
      },
    );
  }
}
