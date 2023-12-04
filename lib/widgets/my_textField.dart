import 'package:flutter/material.dart';

Widget MyTextField({controller,obsecureText,String?title}){

  return TextFormField(
    controller: controller,
    obscureText: obsecureText,
    decoration: InputDecoration(
        labelText: title!,
        border:   OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        )
    ),
  );
}
Widget MyTextFields({controller,icon}){

  return TextFormField(
    controller: controller,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: icon,
        enabledBorder:   OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white)
        )
    ),
  );
}