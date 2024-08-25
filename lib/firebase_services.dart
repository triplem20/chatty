import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatServices{

final FirebaseFirestore _firebaseF = FirebaseFirestore.instance;

Stream<QuerySnapshot> getUsersStream() {
  return _firebaseF.collection('users').snapshots();
}


}