import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget dropDownButton({
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  String? dropdownValue,
  List<String>? languages,
}) {
  return Obx(
    () => Container(
      padding: padding,
      //EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFE64D3D),
      ),
      child: DropdownButton(
          iconSize: 0,
          underline: SizedBox(),
          value: dropdownValue,
          items: languages?.map((String languages) {
            return DropdownMenuItem(
              child: Text(
                languages,
                style: TextStyle(color: Colors.white),
              ),
              value: languages,
            );
          }).toList(),
          onChanged: (String? newValue) {
            dropdownValue = newValue!;
          }),
    ),
  );
}
