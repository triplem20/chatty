import 'package:flutter/material.dart';


class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.person,size: 30,color: Colors.black,),
              SizedBox(width: 20,),
              Text(text,style: TextStyle(color:Colors.black,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
