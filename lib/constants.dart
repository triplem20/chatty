import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.teal, width: 2.0),
  ),
);

var kTextFieldDecoration =  InputDecoration(
  labelText: 'Email',
  labelStyle: const TextStyle(
    color: Colors.teal, // Label color
    fontSize: 16, // Label font size
  ),
  hintText: 'Enter your email',
  hintStyle: const TextStyle(
    color: Colors.white, // Hint text color
  ),
  prefixIcon: const Icon(
    Icons.email, // Icon for the text field
    color: Colors.teal, // Icon color
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
);

