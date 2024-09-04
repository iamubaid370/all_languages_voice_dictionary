// import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
// import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
// import 'package:all_languages_voice_dictionary/View/splash_screen/splash4.dart';
// import 'package:all_languages_voice_dictionary/onboarding/onboarding_controller.dart';
// import 'package:all_languages_voice_dictionary/onboarding/onboarding_items.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class OnboardingScreen extends StatefulWidget {
//    OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final controller = OnBoardingItems();
//
//   final pageController = PageController();
//
//   //OnBoardingController onBoardingController = Get.put(OnBoardingController());
//   HomeScreenController homeScreenController = Get.put(HomeScreenController());
//   bool isLastPage = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomSheet: Container(
//         margin: EdgeInsets.symmetric(vertical: 10),
//         child: isLastPage ? getStarted() : Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SmoothPageIndicator(
//               controller: pageController,
//               count: controller.items.length,
//               effect: WormEffect(
//                 activeDotColor: Color(0xFFE64D3D),
//                 dotHeight:10,
//                 dotWidth: 10,
//               ),
//               onDotClicked: (index) => pageController.animateToPage(index,duration:Duration(milliseconds: 600), curve: Curves.easeIn),
//             ),
//             TextButton(onPressed: (){
//               pageController.nextPage(duration:Duration(milliseconds: 600), curve: Curves.easeIn);
//             }, child: Text('Next')),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: Get.height*0.1,
//             child: TextButton(
//                 onPressed: (){pageController.jumpToPage(controller.items.length-1);}, child: Padding(
//                   padding: EdgeInsets.only(left:Get.width * 0.7,top: Get.height*0.05),
//                   child: Text('Skip',style: TextStyle(color: Colors.grey),),
//                 )),
//           ),
//           Container(
//             height: Get.height* 0.9,
//             //margin: EdgeInsets.only(top: Get.height * 0.05),
//             child: PageView.builder(
//                 onPageChanged: (index)=> setState(() {
//                   isLastPage =controller.items.length-1==index;
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//                   print(isLastPage);
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//                   print('---------------------');
//
//                 }),
//                 itemCount: controller.items.length,
//                 controller: pageController,
//                 itemBuilder: (context,index){
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//
//                       Text(controller.items[index].title, style: TextStyle(
//                         fontSize: 18,
//                         fontFamily: 'Arial',
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xFFE64D3D),),),
//                       Text(controller.items[index].description,style: TextStyle(
//                           fontSize: 11,
//                           fontFamily: 'Arial',
//                           //fontWeight: FontWeight.w700,
//                           color: Colors.grey),),
//                       SizedBox(height: Get.height* 0.08,),
//                       Image.asset(controller.items[index].image,
//                         width: Get.width/1.3,
//                         height: MediaQuery.of(context).size.height * 0.3,),
//
//                     ],
//                   );
//                 }),
//
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget getStarted(){
//     return Container(
//       width: Get.width*.9,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Color(0xFFE64D3D),
//             borderRadius: BorderRadius.circular(12),
//       ),
//         child: TextButton(onPressed: () async {
//
//           //if(!mounted)return;
//           try{
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             bool result = await prefs.setBool('onboarding', true);
//             if (result) {
//               Get.off(() => HomeScreen());
//             } else {
//               print('Failed to save shared preference');
//               print('Failed to save shared preference');
//               print('Failed to save shared preference');
//               print('Failed to save shared preference');
//               print('Failed to save shared preference');
//               print('Failed to save shared preference');
//
//               print('Failed to save shared preference');
//               print('Failed to save shared preference');
//
//             }
//           }catch(e){'Failed to save share preference:$e';}
//
//
//         }, child: Text('Get Started'),));
//   }
// }
//



///onboarding

// import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   @override
//   OnboardingScreenState createState() => OnboardingScreenState();
// }
//
// class OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   HomeScreenController homeScreenController = Get.put(HomeScreenController());
//   int _currentPage = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//               children: [
//                 _buildPage(
//                 title: 'All Languages Voice Dictionary',
//                 description: 'Discover words meaning, hear accurate pronounciations,\n'
//                     ' and expand your dictionary with our voice dictionary',
//                 image: 'assets/splash1.png'),
//                 _buildPage(
//                     title:  'Instant Translation',
//                     description:'Our Translation feature makes it simple to understand and language.\n'
//                         '        Just enter your text and get a clear translation in seconds',
//                     image: "assets/splash2.png"
//                 ),
//                 _buildPage(
//                     title: 'Save The Words',
//                     description:  'Easily save and organize words you want to learn.\n'
//                         'Our feature lets you build your own personal dictinary ',
//                     image:"assets/splash3.png"
//                 ),
//               ],
//             ),
//           ),
//           _buildIndicator(),
//           _buildButtons(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPage(
//       {required String image,
//         required String title,
//         required String description}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(image, width: 400,
//           height: MediaQuery.of(context).size.height * 0.3,),
//         SizedBox(height: 20),
//         Text(title,style: TextStyle(
//             fontSize: 18,
//             fontFamily: 'Arial',
//             fontWeight: FontWeight.w800,
//             color: Color(0xFFE64D3D)),),
//         SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Text(
//             description,
//             textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 11,
//                   fontFamily: 'Arial',
//                   //fontWeight: FontWeight.w700,
//                   color: Colors.grey)
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) {
//         return Container(
//           margin: EdgeInsets.all(4),
//           width: _currentPage == index ? 12 : 8,
//           height: 8,
//           decoration: BoxDecoration(
//             color: _currentPage == index ? Colors.blue : Colors.grey,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildButtons() {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TextButton(
//             onPressed: _skip,
//             child: Text('Skip'),
//           ),
//           ElevatedButton(
//             onPressed: _currentPage == 2 ? _finishOnboarding : _nextPage,
//             child: Text(_currentPage == 2 ? 'Done' : 'Next'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _nextPage() {
//     _pageController.nextPage(
//       duration: Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//   }
//
//   void _skip() {
//     _finishOnboarding();
//   }
//
//   void _finishOnboarding() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('seenOnboarding', true);
//     Get.offNamed('/dash');
//   }
// }
///
///
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../global/global_variables.dart';
import '../home_screen/home_screen.dart';
import 'onboarding_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnBoardingItems();
  final pageController = PageController();
  OnBoardingController onBoardingController = Get.put(OnBoardingController());

  bool isLastPage = false;
  bool showSecondAd = false;
  bool showThirdAd = false;

  @override
  void dispose() {
    onBoardingController.adsHelper.nativeAd?.dispose();
    onBoardingController.adsHelper.nativeAd = null;

    onBoardingController.adsHelper.nativeAd2?.dispose();
    onBoardingController.adsHelper.nativeAd2 = null;

    onBoardingController.adsHelper.nativeAd3?.dispose();
    onBoardingController.adsHelper.nativeAd3 = null;
    pageController.dispose();
    super.dispose();
    print('Screen Dispose Called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //Skip Button
            TextButton(
                onPressed: ()=>pageController.jumpToPage(controller.items.length-1),
                child:  Text("Skip".tr)),

            //Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index)=> pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Color(0xFFE64D3D),
              ),
            ),

            //Next Button
            TextButton(
                onPressed: ()=>pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child:  Text("Next".tr),
            ),


          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index){
              setState((){
                isLastPage = controller.items.length-1 == index;

                //  if (index == controller.items.length - 2) {
                //   onBoardingController.loadSecondAd();
                //   showSecondAd = true;
                //   showThirdAd = false;
                //   onBoardingController.adsHelper.nativeAd3?.dispose();
                //   onBoardingController.adsHelper.nativeAd3 = null;
                //
                // } else if(index == controller.items.length-1){
                //   onBoardingController.loadThirdAd();
                //   showThirdAd = true;
                //   showSecondAd = false;
                //   onBoardingController.adsHelper.nativeAd2?.dispose();
                //   onBoardingController.adsHelper.nativeAd2 = null;
                //
                // }else{
                //   showSecondAd = false;
                //   showThirdAd= false;
                // }
              });
              },
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              NativeAd? ad = onBoardingController.getAd(index);
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //color: Colors.blue,
                      height: Get.height*0.6,
                      child: Padding(
                        padding:  EdgeInsets.only(top: Get.height*0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(controller.items[index].title.tr, style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFE64D3D),),),
                            Text(controller.items[index].description.tr,style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Arial',
                                //fontWeight: FontWeight.w700,
                                color: Colors.grey),),
                            SizedBox(height: Get.height* 0.08,),
                            Image.asset(controller.items[index].image,
                              width: Get.width/1.3,
                              height: MediaQuery.of(context).size.height * 0.3,),

                          ],
                        ),
                      ),
                    ),
                    /// ads
                    // showSecondAd ?Obx(
                    //       () => (onBoardingController.adsHelper.isNativeAd2Loaded.value &&
                    //       !GlobalVariable.isAppOpenAdShowing.value &&onBoardingController.adsHelper.nativeAd2 != null)
                    //       ? Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 3, vertical: 2),
                    //     child: SizedBox(
                    //       width:360,
                    //       height: 232,
                    //       // homeScreenController.adsHelper.bannerAd!.size.height
                    //       //     .toDouble(),
                    //
                    //       child: AdWidget(
                    //         ad: onBoardingController.adsHelper.nativeAd2!,
                    //       ),
                    //
                    //     ),)
                    //       : (!GlobalVariable.isPurchasedMonthly.value &&
                    //       !GlobalVariable.isPurchasedYearly.value &&
                    //       !GlobalVariable.isPurchasedLifeTime.value)
                    //       ? SizedBox()
                    //   // Expanded(
                    //   // flex: 1,
                    //   // child: Shimmer.fromColors(
                    //   //     baseColor: Colors.black,
                    //   //     highlightColor: Colors.white,
                    //   //     child: const NewsCardSkelton()),
                    //   //    )
                    //       : const SizedBox(),
                    // ):
                    // (showThirdAd)?Obx(
                    //       () => (onBoardingController.adsHelper.isNativeAd3Loaded.value &&
                    //       !GlobalVariable.isAppOpenAdShowing.value &&onBoardingController.adsHelper.nativeAd3 != null)
                    //       ? Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 3, vertical: 2),
                    //     child: SizedBox(
                    //       width:360,
                    //       height: 232,
                    //       // homeScreenController.adsHelper.bannerAd!.size.height
                    //       //     .toDouble(),
                    //
                    //       child: AdWidget(
                    //           ad: onBoardingController.adsHelper.nativeAd3!
                    //       ),
                    //     ),)
                    //       : (!GlobalVariable.isPurchasedMonthly.value &&
                    //       !GlobalVariable.isPurchasedYearly.value &&
                    //       !GlobalVariable.isPurchasedLifeTime.value)
                    //       ? SizedBox()
                    //   // Expanded(
                    //   // flex: 1,
                    //   // child: Shimmer.fromColors(
                    //   //     baseColor: Colors.black,
                    //   //     highlightColor: Colors.white,
                    //   //     child: const NewsCardSkelton()),
                    //   //    )
                    //       : const SizedBox(),
                    // )
                    //     :Obx(
                    //       () => (onBoardingController.adsHelper.isNativeAdLoaded.value &&
                    //       !GlobalVariable.isAppOpenAdShowing.value &&onBoardingController.adsHelper.nativeAd != null)
                    //       ? Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 3, vertical: 2),
                    //     child: SizedBox(
                    //       width:360,
                    //       height: 232,
                    //       // homeScreenController.adsHelper.bannerAd!.size.height
                    //       //     .toDouble(),
                    //
                    //       child: AdWidget(
                    //           ad: onBoardingController.adsHelper.nativeAd!
                    //       ),
                    //     ),)
                    //       : (!GlobalVariable.isPurchasedMonthly.value &&
                    //       !GlobalVariable.isPurchasedYearly.value &&
                    //       !GlobalVariable.isPurchasedLifeTime.value)
                    //       ? SizedBox()
                    //   // Expanded(
                    //   // flex: 1,
                    //   // child: Shimmer.fromColors(
                    //   //     baseColor: Colors.black,
                    //   //     highlightColor: Colors.white,
                    //   //     child: const NewsCardSkelton()),
                    //   //    )
                    //       : const SizedBox(),
                    // ),



                  if(ad!=null)  ConstrainedBox(
                constraints: const BoxConstraints(
                  // minWidth: 320, // minimum recommended width
                  // minHeight: 320, // minimum recommended height
                  maxWidth: 360,
                  maxHeight: 232,

                ),
                child: AdWidget(ad: ad),
              )

                // ad!=null? Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 3, vertical: 2),
                //     child: SizedBox(
                //       width:360,
                //       height: 232,
                //       // homeScreenController.adsHelper.bannerAd!.size.height
                //       //     .toDouble(),
                //
                //       child: AdWidget(
                //         ad: onBoardingController.adsHelper.nativeAd2!,
                //       ),
                //     )
                // ):SizedBox()

                    /// ads
                    // Obx(() {
                    //   if (showSecondAd) {
                    //     if (
                    //     onBoardingController.adsHelper.isNativeAd2Loaded.value &&
                    //         onBoardingController.adsHelper.nativeAd2 != null &&
                    //         !GlobalVariable.isAppOpenAdShowing.value
                    //     ) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    //         child: SizedBox(
                    //           width: 360,
                    //           height: 232,
                    //           child: AdWidget(
                    //             ad: onBoardingController.adsHelper.nativeAd2!,
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   }
                    //
                    //   if (showThirdAd) {
                    //     if (onBoardingController.adsHelper.isNativeAd3Loaded.value &&
                    //         onBoardingController.adsHelper.nativeAd3 != null &&
                    //         !GlobalVariable.isAppOpenAdShowing.value) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    //         child: SizedBox(
                    //           width: 360,
                    //           height: 232,
                    //           child: AdWidget(
                    //             ad: onBoardingController.adsHelper.nativeAd3!,
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   }
                    //
                    //   if (onBoardingController.adsHelper.isNativeAdLoaded.value &&
                    //       onBoardingController.adsHelper.nativeAd != null &&
                    //       !GlobalVariable.isAppOpenAdShowing.value) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    //       child: SizedBox(
                    //         width: 360,
                    //         height: 232,
                    //         child: AdWidget(
                    //           ad: onBoardingController.adsHelper.nativeAd!,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    //
                    //   // Check if the user has purchased a subscription and show an empty SizedBox if they have
                    //   if (!GlobalVariable.isPurchasedMonthly.value &&
                    //       !GlobalVariable.isPurchasedYearly.value &&
                    //       !GlobalVariable.isPurchasedLifeTime.value) {
                    //     return SizedBox(); // No ad available
                    //   }
                    //
                    //   return const SizedBox(); // User has purchased a subscription
                    // })

              ],
                ),
              );

            }),
      ),
    );
  }

   Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFE64D3D)
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: ()async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool("seenOnboarding", true);

            if(!mounted)return;

            if (onBoardingController.adsHelper.interstitialAd !=
                null) {
              onBoardingController.adsHelper
                  .showInterstitialAd(nextScreen: '/home');
              print('interstitial ad load successfuly');
            } else {
              onBoardingController.adsHelper
                  .showInterstitialAd(nextScreen: '/home');
              print('interstitial ad not loaded');
            }
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          },
          child:  Text("Get started".tr,style: TextStyle(color: Colors.white),)),
    );
  }
}

