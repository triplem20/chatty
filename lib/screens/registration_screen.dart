import 'package:chatty/components/rounded_button.dart';
import 'package:chatty/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chats_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  late String email;
  late String username;
  late String password;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>(); // Form key to manage form state

  Future<void> registerUser(String email, String password, String displayName) async {
    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the registered user
      User? user = userCredential.user;

      // Save user details to Firestore
      if (user != null) {
        await _firestore.collection('users').add({
          'email': email,
          'username': displayName,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error registering user: $e');
      // Handle errors, e.g., show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering user: $e')),
      );
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Image.asset('images/logo1.png'),
            SizedBox(width: 50,),
            Text('Register'),
          ],
        ),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 90.0,horizontal: 10),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.grey),
                  controller: emailController,
                  decoration:  InputDecoration(
                    icon:  const Icon(
                      Icons.email, // Icon for the text field
                      color: Colors.brown, // Icon color
                    ),
              labelText: 'Email',
              labelStyle: const TextStyle(
                color: Colors.teal, // Label color
                fontSize: 16, // Label font size
              ),
              hintText: 'Enter your Email',
              hintStyle: const TextStyle(
                color: Colors.grey, // Hint text color
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.brown, // Border color when enabled
                  width: 1.5, // Border width when enabled
                ),
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.brown, // Border color when focused
                  width: 2.0, // Border width when focused
                ),
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red, // Border color when there's an error
                  width: 1.5, // Border width when there's an error
                ),
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red, // Border color when focused and there's an error
                  width: 2.0, // Border width when focused and there's an error
                ),
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Padding inside the text field
            ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  style: TextStyle(color: Colors.grey),
                  controller: passwordController,
                  decoration:  InputDecoration(
                    icon: Icon(
                      Icons.password, // Icon for the text field
                      color: Colors.brown, // Icon color
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.teal, // Label color
                      fontSize: 16, // Label font size
                    ),
                    hintText: 'Enter your Password',
                    hintStyle: const TextStyle(
                      color: Colors.grey, // Hint text color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.brown, // Border color when enabled
                        width: 1.5, // Border width when enabled
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.brown, // Border color when focused
                        width: 2.0, // Border width when focused
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, // Border color when there's an error
                        width: 1.5, // Border width when there's an error
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, // Border color when focused and there's an error
                        width: 2.0, // Border width when focused and there's an error
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Padding inside the text field
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  style: TextStyle(color: Colors.grey),
                  controller: displayNameController,
                  decoration: InputDecoration(
                    icon:  Icon(
                      Icons.person, // Icon for the text field
                      color: Colors.brown, // Icon color
                    ),
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(
                      color: Colors.teal, // Label color
                      fontSize: 16, // Label font size
                    ),
                    hintText: 'Enter your FullName',
                    hintStyle: const TextStyle(
                      color: Colors.grey, // Hint text color
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.brown, // Border color when enabled
                        width: 1.5, // Border width when enabled
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.brown, // Border color when focused
                        width: 2.0, // Border width when focused
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, // Border color when there's an error
                        width: 1.5, // Border width when there's an error
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, // Border color when focused and there's an error
                        width: 2.0, // Border width when focused and there's an error
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Padding inside the text field
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Full Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(

                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // If all fields are valid, proceed with registration
                      setState(() {
                        showSpinner = true; // Show spinner while processing
                      });
                      await registerUser(
                        emailController.text,
                        passwordController.text,
                        displayNameController.text,
                      );
                      setState(() {
                        showSpinner = false; // Hide spinner when done
                      });
                      Navigator.pushNamed(context, ChatsScreen.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,// Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding inside the button
                    minimumSize: Size(450, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
