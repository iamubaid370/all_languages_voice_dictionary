import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextButton(
    {required VoidCallback voidcallbaack, required String title,EdgeInsets? padding,EdgeInsets? margin}) {
  return Container(
    margin: margin,
    child: TextButton(
      onPressed: voidcallbaack,
      child: Text(title,style: TextStyle(color: Colors.grey),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0.r),
                   // side: BorderSide(color: Colors.red)
                )
            ),
        )
    ),
  );
}
