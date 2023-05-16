import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget{
  OptionButton( {
    required this.optionText,
    required this.onTap,
    super.key});
  final String optionText;
  final void Function() onTap;
  @override
  Widget build(context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF00caac),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
      ),
      onPressed: onTap,
      child: Text(optionText, textAlign: TextAlign.center,),);
  }
}