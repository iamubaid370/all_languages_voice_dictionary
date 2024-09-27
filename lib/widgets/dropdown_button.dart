// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// Widget dropDownButton({
//   EdgeInsetsGeometry? padding,
//   EdgeInsetsGeometry? margin,
//   String? dropdownValue,
//   List<String>? languages,
// }) {
//   return Obx(
//     () => Container(
//       padding: padding,
//       //EdgeInsets.only(left: 10,right: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Color(0xFFE64D3D),
//       ),
//       child: DropdownButton(
//           iconSize: 0,
//           underline: SizedBox(),
//           value: dropdownValue,
//           items: languages?.map((String languages) {
//             return DropdownMenuItem(
//               child: Text(
//                 languages,
//                 style: TextStyle(color: Colors.white),
//               ),
//               value: languages,
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             dropdownValue = newValue!;
//           }),
//     ),
//   );
// }

import 'package:all_languages_voice_dictionary/constants/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget customDropDownButton(RxString dropDownValue, Function(String?) onChanged,
    Color color, Color color2) {
  // var languages = [
  //   'English',
  //   'Urdu',
  //   'Pashto',
  //   'Saraiki',
  //   'Arabi',
  //   'Punjabi',
  //   'Spanish',
  //   'Turkish',
  //   'Spanish',
  //   'French',
  //   'Russian',
  //   'German',
  //   'Italian',
  //   'Hindi',
  //   'Japanese',
  //   'Arabic',
  //   'Korean',
  //   // 'Portuguese (PT)',
  //   // 'Portuguese (BR)',
  //   // 'Chinese (Simplified)',
  //   // 'Chinese (Traditional)',
  //   // 'Turkish',
  //   // 'Vietnamese',
  //   // 'Thai',
  //   // 'Polish',
  //   // 'Dutch',
  //   // 'Swedish',
  //   // 'Danish',
  //   // 'Norwegian',
  //   // 'Finnish',
  //   // 'Hungarian',
  //   // 'Czech',
  //   // 'Slovak',
  //   // 'Romanian',
  //   // 'Bulgarian',
  //   // 'Greek',
  //   // 'Hebrew',
  //   // 'Swahili',
  //   // 'Malay',
  //   // 'Indonesian',
  //   // 'Serbo-Croatian',
  //   // 'Lithuanian',
  //   // 'Latvian',
  //   // 'Estonian',
  //   // 'Icelandic',
  //   // 'Irish',
  //   // 'Catalan',
  //   // 'Basque',
  //   // 'Galician',
  //
  // ];

  return Obx(() => DropdownButton(
        style: TextStyle(color: Colors.white),
        iconSize: 0,
        underline: SizedBox(),
        value: dropDownValue.value,
        items: StringConstants.languages.map((String language) {
          return DropdownMenuItem(
            child: Text(
              language,
              style: TextStyle(
                  color: color2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Arial'),
            ),
            value: language,
          );
        }).toList(),
        onChanged: onChanged,
        // menuWidth: 135.w,

        ///TODO
        borderRadius: BorderRadius.circular(8),
        //dropdownColor: Color(0xFFEFEFEF),
        dropdownColor: color,
      ));
}
