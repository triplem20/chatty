import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {


  final String buttonText;
  final onPressed;
  final Color Bcolor;
  const RoundedButton({Key? key,required this.buttonText, required this.Bcolor,required this.onPressed});


  @override
  Widget build(BuildContext context ) {
    return
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color: Bcolor,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              buttonText,
            ),
          ),
        ),
      );
  }


}