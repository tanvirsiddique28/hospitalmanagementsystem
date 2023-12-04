import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget MyButtons({String?title,onPress,width,height}){

  return ElevatedButton(
      onPressed: onPress,
      child:Text( title!,style: GoogleFonts.roboto(fontSize:18,),),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )
      ),

  );
}