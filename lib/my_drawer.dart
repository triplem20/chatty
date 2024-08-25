import 'package:chatty/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final  _auth =FirebaseAuth.instance;


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
DrawerHeader(child: Icon(Icons.message,size: 80,color: Colors.black,)),
          ListTile(
            title: Text('Home',style: TextStyle(color: Colors.black),),
            leading: Icon(Icons.home,color: Colors.black,),
            onTap: () {
              Navigator.pop(context);
            }
          ),
          ListTile(
              title: Text('Settings',style: TextStyle(color: Colors.black)),
              leading: Icon(Icons.settings,color: Colors.black,),
              onTap: () {}
          ),
          ListTile(
              title: Text('Logout',style: TextStyle(color: Colors.black)),
              leading: Icon(Icons.logout,color: Colors.black,),
              onTap: () {

                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }
          ),

        ],
      ),
    );
  }
}
