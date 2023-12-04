import 'package:flutter/material.dart';

Widget MyContainer({String?title,onPress,icon,color}) {
  return GestureDetector(
      onTap: onPress ,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(icon,color: Colors.purple,size: 100),
            ),
            Center(
                child: Text(
              title!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ));
}
Widget MyContainers({String?title,onPress,image,color}) {
  return GestureDetector(
      onTap: onPress ,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(image,height: 150,width: 150,),
            ),
            Center(
                child: Text(
                  title!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amberAccent),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ));
}
Widget MyContain({String?title,onPress,icon,color}) {
  return GestureDetector(
      onTap: onPress ,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(icon,color: Colors.white,size: 100,),
            ),
            Center(
                child: Text(
                  title!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amberAccent),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ));
}
