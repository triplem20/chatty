import 'package:chatty/components/rounded_button.dart';
import 'package:chatty/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';
import 'chats_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Image.asset('images/logo1.png'),
            SizedBox(width: 50,),
            Text('Login'),
          ],
        ),
      
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email,color: Colors.teal,),
                    labelStyle: const TextStyle(
                      color: Colors.brown, // Label color
                      fontSize: 16, // Label font size
                    ),
                    hintText: 'Enter Your Email',
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
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,

                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.password,color: Colors.teal,),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.brown, // Label color
                      fontSize: 16, // Label font size
                    ),
                    hintText: 'Enter Your Password',
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
                SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final existingUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (existingUser != null) {
                        Navigator.pushNamed(context, ChatsScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal, // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding inside the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
