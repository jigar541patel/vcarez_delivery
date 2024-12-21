import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/custom_app_bar.dart';
import '../components/my_form_field.dart';
import '../components/my_theme_button.dart';
import '../components/standard_regular_text.dart';
import '../utils/colors_utils.dart';
import '../utils/images_utils.dart';
import '../utils/strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _userNameController;

  void initController() {
    _userNameController = TextEditingController();
  }

  void disposeController() {
    _userNameController.dispose();
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeController();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageAppLogo() => SvgPicture.asset(
          appLogo_,
          height: 30.0,
          width: 116.0,
        );
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          createStandardAppBar(context: context,size:  MediaQuery.of(context).size.height * .26),

          // SizedBox(
          //   height: MediaQuery.of(context).size.height * .26,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage(loginBg),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     child: Align(
          //       alignment: Alignment.topLeft,
          //       child: Padding(
          //         padding: const EdgeInsets.only(top: 20.0,left: 1),
          //         child: Row(
          //           children: [
          //             const SizedBox(
          //               width: 20.0,
          //
          //             ),
          //             InkWell(
          //                 onTap: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Icon(
          //                   Icons.arrow_back_ios,
          //                   color: whiteColor,
          //                 )),
          //             imageAppLogo(),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .09,
            ),
            height: MediaQuery.of(context).size.height * .90,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(0.0)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top:40,left: 16.0, right: 16, bottom: 100),
                child: Form(
                  key: _formKey,
                  child: Column(

                    children: [
                      const StandardCustomText(
                        label: forgotPassword,
                        fontWeight: FontWeight.bold,
                        color: darkSkyBluePrimaryColor,
                        fontSize: 24.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const StandardCustomText(
                        fontSize: 12,
                        label: forgotPasswordSubtitle,
                        color: descriptionTextColor,
                        maxlines: 2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50.0),
                        child: MyFormField(
                          controller: _userNameController,
                          labelText: 'Enter Email or Mobile Number*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return usernameError;
                            }
                            return null;
                          },
                          isRequire: true,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24.0),
                        child: MyThemeButton(
                          buttonText: sendLink,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              onLoginButtonClicked();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  void onLoginButtonClicked() {
    Navigator.pop(context);
  }
}
