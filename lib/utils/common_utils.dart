import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../components/color_loader.dart';
import '../components/my_theme_button.dart';
import '../components/standard_regular_text.dart';
import 'SizeConfig.dart';
import 'colors_utils.dart';


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class CommonUtils {
  static final CommonUtils utils = CommonUtils._internal();
  static var userToken = "";

  factory CommonUtils() {
    return utils;
  }

  CommonUtils._internal();

  // handleApiError(int code, String message) {
  //   switch (code) {
  //     case 301:
  //       Get.to(() => ErrorScreen(
  //             buttonText: backText,
  //             imageAssets: noConnectionError,
  //             onPressed: () => Get.back(),
  //           ));
  //       break;
  //
  //     case 400:
  //       ShowAlertDialog().showAppDialog(
  //         title: error,
  //         message: /*message*/ 'Something Wen\'t Wrong!',
  //         confirmColor: colorPrimary,
  //         image: warningError,
  //         cancelColor: Colors.grey.shade50,
  //         confirmText: ok,
  //         isCancel: false,
  //         onConfirm: () {
  //           Get.back();
  //         },
  //       );
  //       break;
  //
  //     case 500:
  //       {
  //         Get.to(
  //           () => ErrorScreen(
  //             imageAssets: errorImg,
  //             buttonText: backText,
  //             onPressed: () {
  //               Get.back();
  //             },
  //           ),
  //         );
  //       }
  //       break;
  //
  //     default:
  //       {
  //         ShowAlertDialog().showAppDialog(
  //           title: error,
  //           message: /* message*/ 'Something Wen\'t Wrong!',
  //           confirmColor: colorPrimary,
  //           image: warningError,
  //           cancelColor: Colors.grey.shade50,
  //           confirmText: ok,
  //           isCancel: false,
  //           onConfirm: () {
  //             Get.back();
  //           },
  //         );
  //       }
  //       break;
  //   }
  // }
  static Widget NoDataFoundPlaceholder(BuildContext context,
      {String? message, String? strAssetImage}) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .65,
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                strAssetImage != null
                    ? Image(
                  image: AssetImage(strAssetImage),
                  height: 50,
                )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                message != null
                    ? Text(message,
                    style: const TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.w500))
                    : const Text("No Data Found",
                    style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.w500)),
              ],
            )));
  }

  showToast(String strMsg, {Color? backgroundColor, Color? textColor}) {
    Fluttertoast.showToast(
        msg: strMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: backgroundColor ?? negativeButtonColor,
        textColor: textColor ?? whiteColor,
        fontSize: 16.0);
  }

  // Future<String> getUserToken() async {
  //   if (userToken.isNotEmpty)
  //     return userToken;
  //   else {
  //     final storage = GetStorage();
  //     userToken = await storage.read(userToken);
  //     return userToken;
  //   }
  // }

  Future<void> copyToClipboard(String text, var key) async {
    await Clipboard.setData(ClipboardData(text: text));
    key.currentState.showSnackBar(SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  // launchWebSiteUrl(String webUrl) async {
  //   var url = webUrl;
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  String? getDeviceType() {
    return Platform.isAndroid ? 'android' : 'ios';
  }

  // redirectToHome() async {
  //   Get.offAll(() => HomeScreenNew());
  //   await Future.delayed(Duration(seconds: 1), () => playAudio('booking4.mp3'));
  // }

  // redirectToPreviousScreen() {
  //   Get.back();
  // }

  // ServiceDuration convertDuration(String serviceTime) {
  //   var duration;
  //   var serviceDuration = ServiceDuration();
  //   if (serviceTime.contains(" ")) {
  //     var durationArray = serviceTime.split(" ");
  //     if (durationArray[1].isAlphabetOnly) {
  //       duration = int.parse(durationArray[0]);
  //       serviceDuration.min = duration;
  //       serviceDuration.hour = 0;
  //     } else {
  //       var hours = int.parse(
  //               durationArray[0].substring(0, durationArray[0].length - 1)) *
  //           60;
  //       var min = int.parse(
  //           durationArray[1].substring(0, durationArray[1].length - 3));
  //       duration = (hours + min);
  //       serviceDuration.min = min;
  //       serviceDuration.hour = (hours ~/ 60);
  //     }
  //   } else {
  //     // ignore: unnecessary_null_comparison
  //     if (serviceTime != null) {
  //       duration =
  //           int.parse(serviceTime.substring(0, serviceTime.length - 1)) * 60;
  //       serviceDuration.min = 0;
  //       serviceDuration.hour = (duration ~/ 60);
  //     }
  //   }
  //   return serviceDuration;
  // }

  double roundOffDouble(double val) {
    num mod = pow(10.0, 1);
    return ((val * mod).round().toDouble() / mod);
  }

  String setProfileImage(String s, String? gender) {
    var profileImage = '';
    return profileImage;
  }

  // String setDefaultUserImage(String? gender) {
  //   var defaultImage = "";
  //   if (gender != null) {
  //     if (gender.isNotEmpty) {
  //       defaultImage =
  //           gender.toLowerCase() == 'male' ? defaultMale : defaultFemale;
  //     } else
  //       defaultImage = defaultMale;
  //   } else
  //     defaultImage = defaultMale;
  //   return defaultImage;
  // }

  hexToColor(String colorString) {
    var color = int.parse(colorString.replaceAll('#', '0xFF'));
    return Color(color);
  }

  maskEmailString(String value) {
    return value.replaceAll(RegExp(r'(?<=.{3}).(?=.*@)'), '*');
  }

  maskNumberString(String value) {
    return value.replaceAll(RegExp(r'(?<=.{3}).(?=.[0-9])'), '*');
  }

  // updateAppointment(BookingFlowModal bookingFlowModal) async {
  //   var dataList = [];
  //   dataList.add(bookingFlowModal);
  //   var requestBody = {
  //     "ios": bookingFlowModal,
  //   };
  //
  //   var responseModel = await ApiController().updateAppointment(
  //       GlobalVariables.userToken,
  //       bookingFlowModal.id!,
  //       json.encode(requestBody));
  //   return responseModel;
  // }

  void hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  onInternetError() async {
    await Future.delayed(
      Duration(seconds: 5),
      () => ColorLoader(),
    );

    // showCustomNoInternetDialog(context);
    // ShowAlertDialog().showAppDialog(
    //     title: 'Connection Error',
    //     message:
    //         'No Internet Connection.\nCheck your Wi-Fi connection\nand try again.',
    //     confirmText: 'Continue',
    //     confirmColor: darkSkyBluePrimaryColor,
    //     image: warningError,
    //     isCancel: false,
    //     onConfirm: () {
    //       // CommonUtils.utils.redirectToHome();
    //     });
  }

  void showCustomNoInternetDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
              color: Colors.transparent,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: SizeConfig.safeBlockVertical! * 30,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      SizeConfig.safeBlockVertical! * 2.0,
                      SizeConfig.safeBlockVertical! * 2.0,
                      SizeConfig.safeBlockVertical! * 2.0,
                      0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: StandardCustomText(
                          label: 'FAQ for rejected order',
                          align: TextAlign.start,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.radio_button_checked_rounded,
                                  color: Color(0xFF00AAFF),
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                StandardCustomText(
                                  label: 'Address is too far.',
                                  fontWeight: FontWeight.bold,
                                  color: descriptionTextColor,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 1.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.radio_button_off_rounded,
                                  color: Color(0xFF8A8F9C),
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                StandardCustomText(
                                  label: 'I don’t have particular reason.',
                                  fontWeight: FontWeight.bold,
                                  color: descriptionTextColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 3.0,
                      ),
                      Center(
                        child: SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 40.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyThemeButton(
                              fontSize: 12,
                              buttonText: 'Submit',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 1.0,
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  // Future<void> customDatePicker(
  //     BuildContext context, TextEditingController controller) async {
  //   DateTime selectedDate = DateTime.now();
  //
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       builder: (context, child) {
  //         return Theme(
  //           data: ThemeData.light().copyWith(
  //             primaryColor: darkSkyBluePrimaryColor,
  //             colorScheme:
  //             const ColorScheme.light(primary: darkSkyBluePrimaryColor),
  //             buttonTheme:
  //             const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  //           ),
  //           child: child!,
  //         );
  //       },
  //       lastDate: DateTime(2100, 1),
  //       firstDate: DateTime.now());
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
  //       controller.text = formattedDate;
  //       selectedDate = DateTime.now();
  //     });
  //   }
  // }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}
