import 'package:flutter/material.dart';
import 'chat_screen.dart';

class NewChatScreen extends StatefulWidget {
  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final _emailController = TextEditingController();

  void _startChat() {
    final email = _emailController.text;
    if (email.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(recieverEmail: email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Start a New Chat')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
            decoration:   InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.message,color: Colors.teal,),
                labelStyle: const TextStyle(
                  color: Colors.brown, // Label color
                  fontSize: 16, // Label font size
                ),
                hintText: 'Enter receiver Email',
                hintStyle: const TextStyle(
                  color: Colors.grey, // Hint text color
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.teal, // Border color when enabled
                    width: 1.5, // Border width when enabled
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.teal, // Border color when focused
                    width: 2.0, // Border width when focused
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Padding inside the text field
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startChat,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,// Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding inside the button
                minimumSize: Size(450, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: Text('Start Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
