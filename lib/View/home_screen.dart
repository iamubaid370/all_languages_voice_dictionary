import 'package:all_languages_voice_dictionary/View/meaning.dart';
import 'package:all_languages_voice_dictionary/controller/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/reusable_widgets/reusable_language_switch.dart';
import 'package:all_languages_voice_dictionary/reusable_widgets/reusable_stack.dart';
import 'package:all_languages_voice_dictionary/reusable_widgets/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.put(HomeScreenController(),);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEFEFEF),
        //resizeToAvoidBottomInset: false,
        body:  SingleChildScrollView(
          child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: Get.height * 0.1.h,
                        width: Get.width.w,
                        //color: Colors.green,
                        margin: EdgeInsets.only(
                            top: 30.h, left: 15.w, right: 15.w, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/drawer.png',
                                height: Get.height * 0.014.h,
                                width: Get.width * 0.07.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/Asset 27.png',
                                height: Get.height * 0.03.h,
                                width: Get.width * 0.09.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                        reusableLangSwitch(
                            context: context,
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                            ),
                            margin1: EdgeInsets.only(right: 8.w),
                            margin2: EdgeInsets.only(left: 8.w)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: Get.height * 0.3.h,
                          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.55),
                            //color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFEFEFEF),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Card(
                            elevation: 2,
                            // color: Color(0xFFD3D3D3),
                            color: Color(0xFFEFEFEF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25.0.w),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Write Something...',
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(bottom: 50.h),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.0.h, right: 10.w),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.favorite_border,
                                              color: Color(0xFFE64D3D),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: homeScreenController.textEditingController,
                                    onChanged: (text){
                                      //homeScreenController.updateTextField(text);
                                      homeScreenController.searchContain(text);
                                    },
                                    maxLines: 3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    customTextButton(
                                        voidcallbaack: () {homeScreenController.updateTextField('decision');},
                                        title: 'Hope',
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.only(left: 25.w)),
                                    customTextButton(
                                        voidcallbaack: () {
                                          homeScreenController.updateTextField('decision');
                                        },
                                        title: 'Decision',
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.only(left: 8.w)),
                                    customTextButton(
                                        voidcallbaack: () {homeScreenController.updateTextField('decision');},
                                        title: 'Satisfaction',
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.only(left: 8.w)),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    customTextButton(
                                        voidcallbaack: () {},
                                        title: 'Hope',
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.only(left: 25.w)),
                                    customTextButton(
                                        voidcallbaack: () {},
                                        title: 'Decision',
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.only(left: 8.w)),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 80.w),
                                        //color: Colors.red,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(
                                            'assets/speaker.png',
                                            height: Get.height * 0.05.h,
                                            width: Get.width * 0.06.w,
                                            //fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      Container(
                        height: Get.height * 0.15.h,
                         //color: Colors.green,
                        margin: EdgeInsets.only(left: 20.w, right: 10.w),
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          scrollDirection: Axis.horizontal,
                          children: [
                            reusableStack(
                                title: 'translation',
                                image1: 'assets/asset.png',
                                image2: 'assets/translation.png',
                                padding: EdgeInsets.only(top: 8.h),
                                padding1: EdgeInsets.only(left: 52.w,bottom: 20.h ),
                                padding2: EdgeInsets.only(top: 60.0.h, left: 18.w,),
                                height: Get.height * 0.1.h,
                                width: Get.width * 0.1.w,
                                onTap: () {}),
                            reusableStack(
                                title: 'History',
                                image1: 'assets/asset.png',
                                image2: 'assets/history.png',
                                padding:
                                    EdgeInsets.only(left: 10.w, top: 8.h, right: 0.w),
                                padding1:
                                    EdgeInsets.only(left: 50.w, bottom: 25.h, top: 20.h),
                                padding2:
                                    EdgeInsets.only(top: 60.0.h, left: 25.w,right: 25.w),
                                height: Get.height * 0.04.h,
                                width: Get.width * 0.1.w,
                                onTap: () {}),
                            reusableStack(
                                title: 'Collection',
                                image1: 'assets/asset.png',
                                image2: 'assets/collection.png',
                                padding:
                                    EdgeInsets.only(left: 0.w, top: 10.h, right: 10.w),
                                padding1:
                                    EdgeInsets.only(left: 50.w, bottom: 20.h, top: 20.h),
                                padding2: EdgeInsets.only(top: 60.0.h, left: 20.w,right: 20.w),
                                height: Get.height * 0.04.h,
                                width: Get.width * 0.1.w,
                                onTap: () {}),

                            reusableStack(
                                title: 'Collection',
                                image1: 'assets/asset.png',
                                image2: 'assets/collection.png',
                                padding:
                                EdgeInsets.only(left: 0.w, top: 10.h, right: 10.w),
                                padding1:
                                EdgeInsets.only(left: 50.w, bottom: 20.h, top: 20.h),
                                padding2: EdgeInsets.only(top: 60.0.h, left: 20.w,right: 20.w),
                                height: Get.height * 0.04.h,
                                width: Get.width * 0.1.w,
                                onTap: () {})

                          ],
                        ),
                      ),
                      TextButton(onPressed: (){Get.to(Meaning());}, child: Text('search')),
                    ],
                  ),
                ),
        ),



      )
    );
  }
}




