import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget drawerCard({required onTap, required IconData icon, required String text}){
  return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon,color: Color(0xFFE64D3D),size: 30,),
        title: Text(text),
      )
  );
}
