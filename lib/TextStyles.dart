import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

dynamic title({
  Color color = Colors.white,
  bool bold=true,
  double size = 20,

}){
  return GoogleFonts.poppins(
    fontWeight: bold?FontWeight.bold:FontWeight.normal,
    fontSize: size,
    color: color

  );
}

dynamic desc({
  Color color = Colors.white,
  bool bold=false,
  double size = 15,

}){
  return GoogleFonts.poppins(
      fontWeight: bold?FontWeight.bold:FontWeight.normal,
      fontSize: size,
      color: color,


  );
}