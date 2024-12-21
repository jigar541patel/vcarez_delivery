import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/my_form_field.dart';
import '../../components/standard_regular_text.dart';
import '../../utils/strings.dart';
import '../utils/colors_utils.dart';
import '../utils/images_utils.dart';
import 'SizeConfig.dart';

// const DefaultStandardPanelPadding = 20.0;
// const _defaultStandardPanelPadding =
// EdgeInsets.all(DefaultStandardPanelPadding);
// const _defaultStandardPanelBackgroundColor = AppColors.panelBackgroundColor;

// const DefaultStandardPanelBorderRadius = 10.0;

// const DefaultListTilePadding =
//     EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
Widget imageAppLogo() => SvgPicture.asset(
      appLogoWithoutText_,
      height: SizeConfig.safeBlockVertical! * 2.8,
      width: SizeConfig.safeBlockHorizontal! * 8.0,
    );

Widget createStandardAppBar({
  required BuildContext context,
  String? title,
  double? size,
  double elevation = 0,
  PreferredSize? bottomPreferredSize,
  // Widget? customTitle,
  // Widget? leading,
  // List<Widget>? actions,
  // IconThemeData? iconTheme,
  // bool centerTitle = true,
  // bool automaticallyImplyLeading = true,

  // Color? backgroundColor = AppColors.appBackgroundColor,
}) {
  SizeConfig().init(context);
  return SizedBox(
    height: size ?? MediaQuery.of(context).size.height * .10,
    child: Container(
      padding: const EdgeInsets.only(top: 7.0, bottom: 10.0, left: 16.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginBg),
          fit: BoxFit.none,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: imageAppLogo(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget standardAppBarWithBackButtonTitle({
  required BuildContext context,
  String? title,
  double? size,
  double elevation = 0,
  PreferredSize? bottomPreferredSize,
}) {
  SizeConfig().init(context);
  return Container(
    height: size ?? MediaQuery.of(context).size.height * .25,
    padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical! * 1,
        left: SizeConfig.safeBlockHorizontal! * 5,
        right: SizeConfig.safeBlockHorizontal! * 5),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(loginBg),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 0.3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: whiteColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: imageAppLogo(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            // height: 30.0,
            height: SizeConfig.safeBlockVertical! * 2.5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: StandardCustomText(
                label: title!,
                fontWeight: FontWeight.bold,
                color: whiteColor,
                fontSize: 22.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget standardAppBarWithSearch({
  required BuildContext context,
  String? title = "",
  double? size,
  double elevation = 0,
  TextEditingController? searchMedicineController,
  PreferredSize? bottomPreferredSize,
}) {
  SizeConfig().init(context);
  return Container(
    height: MediaQuery.of(context).size.height * .25,
    padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical! * 1,
        left: SizeConfig.safeBlockHorizontal! * 5,
        right: SizeConfig.safeBlockHorizontal! * 5),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(loginBg),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: whiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: imageAppLogo(),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          // height: 30.0,
          height: SizeConfig.safeBlockVertical! * 3.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: StandardCustomText(
              label: title ?? '',
              fontWeight: FontWeight.bold,
              color: whiteColor,
              fontSize: 22.0,
            ),
          ),
        ),
        searchMedicineController != null
            ? Container(
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 2.2),
                child: MyFormField(
                  controller: searchMedicineController,
                  labelText: searchMedicine,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return usernameError;
                    }
                    return null;
                  },
                  icon: searchMenuIcon,
                  isRequire: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
              )
            : SizedBox(),
      ],
    ),
  );
}

// Scaffold createStandardScaffold(
//     {GlobalKey<ScaffoldState>? key,
//     required Widget body,
//     PreferredSizeWidget? appBar,
//     Color backgroundColor = AppColors.appBackgroundColor,
//     bool extendBodyBehindAppBar = true,
//     bool resizeToAvoidBottomInset = true,
//     FloatingActionButtonLocation? floatingActionButtonLocation,
//     bool drawerEnableOpenDragGesture = true,
//     Widget? floatingActionButton,
//     Widget? drawer,
//     Widget? bottomNavigationBar}) {
//   return Scaffold(
//     key: key,
//     backgroundColor: backgroundColor,
//     appBar: appBar,
//     extendBodyBehindAppBar: extendBodyBehindAppBar,
//     body: body,
//     floatingActionButtonLocation: floatingActionButtonLocation,
//     floatingActionButton: floatingActionButton,
//     drawer: drawer,
//     resizeToAvoidBottomInset: resizeToAvoidBottomInset,
//     drawerEnableOpenDragGesture: true,
//     bottomNavigationBar: bottomNavigationBar,
//   );
// }

// Container createStandardFormPanel(
//     {required Widget child,
//       double borderRadius = DefaultStandardPanelBorderRadius,
//       Color color = _defaultStandardPanelBackgroundColor,
//       EdgeInsets padding = _defaultStandardPanelPadding}) {
//   return Container(
//     padding: EdgeInsets.only(
//         top: DefaultStandardPanelPadding,
//         left: DefaultStandardPanelPadding,
//         right: DefaultStandardPanelPadding),
//     width: double.infinity,
//     child: ClipRRect(
//         borderRadius: BorderRadius.circular(borderRadius),
//         child: Container(padding: padding, color: color, child: child)),
//   );
// }

// Column createStandardLoaderWithText(String? text,
//     {Color textColor = AppColors.textColor}) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: <Widget>[
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           CircularProgressIndicator(),
//         ],
//       ),
//       Padding(
//           padding: EdgeInsets.only(top: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               StandardText(
//                 text: text,
//                 textColor: textColor,
//               )
//             ],
//           ))
//     ],
//   );
// }
