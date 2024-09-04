import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> customDialogBox(
    {required String title,
    required String content,
    required BuildContext context,
    required VoidCallback voidCallBack,
    required VoidCallback voidCallBack2}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFE64D3D),
        title:
            Center(child: Text(title, style: TextStyle(color: Colors.white))),
        content: Text(content,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600)),
        actions: <Widget>[
          TextButton(
            child: Text(
              'YES',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: voidCallBack,
          ),
          TextButton(
              child: Text('NO', style: TextStyle(color: Colors.white)),
              onPressed: voidCallBack2),
        ],
      );
    },
  ).then((value) => value ?? false);
}
