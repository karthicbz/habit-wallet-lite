import 'package:flutter/material.dart';

class CustomPageRoute{
  final BuildContext context;
  final Widget? widget;

  const CustomPageRoute({
    this.widget,
    required this.context
  });

  Future<Object?> push(){
    return Navigator.push(context, MaterialPageRoute(builder: (context)=>widget!));
  }

  void pop(){
    return Navigator.pop(context);
  }
}