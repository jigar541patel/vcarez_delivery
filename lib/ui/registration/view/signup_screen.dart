import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vcarez_delivery/ui/dashboard/view/dashboard_screen.dart';
import 'package:vcarez_delivery/ui/registration/bloc/register_bloc.dart';
import 'package:vcarez_delivery/ui/registration/model/add_delivery_man_request_model.dart';

import '../../../components/SizeConfig.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../components/my_form_field.dart';
import '../../../components/standard_regular_text.dart';
import '../../../components/my_theme_button.dart';
import '../../../dialog/popup_dialog.dart';
import '../../../services/configuration_service.dart';
import '../../../utils/colors_utils.dart';
import '../../../utils/images_utils.dart';
import '../../../utils/route_names.dart';
import '../../../utils/strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _userNameController,
      _phoneController,
      _emailController,
      _homeAddressController,
      _passwordController;
  int intUploadIDNumber = 0;
  File? _licenseImageFile;
  File? _adhaarImageFile;

  void initController() {
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _homeAddressController = TextEditingController();


    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _homeAddressController = TextEditingController();

    _userNameController.text="jigar";
    _passwordController.text="123456";
    _phoneController.text="8905672340";
    _emailController.text="jigartest@gmail.com";
    _homeAddressController.text="near hesm com";

  }

  final ConfigurationService? configurationService = ConfigurationService();


  RegisterBloc registerBloc = RegisterBloc();
  AddDeliveryMenRequestModel addDeliveryMenRequestModel =
      AddDeliveryMenRequestModel();

  void disposeController() {
    _userNameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _homeAddressController.dispose();
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
    SizeConfig().init(context);
    Widget imageAppLogo() => SvgPicture.asset(
          appLogoWithoutText_,
          height: 40,
          width: 100,
        );
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(loginBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: imageAppLogo(),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .23,
            ),
            height: MediaQuery.of(context).size.height * .75,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(0.0)),
            ),
            child: BlocProvider(
              create: (context) => registerBloc,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const StandardCustomText(
                          label: signup,
                          fontWeight: FontWeight.bold,
                          color: darkSkyBluePrimaryColor,
                          fontSize: 30.0,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        const StandardCustomText(
                          label: signupSubtitle,
                          color: descriptionTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          child: MyFormField(
                            controller: _userNameController,
                            labelText: name,
                            /*validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return nameError;
                                }
                                return null;
                              },*/
                            icon: usernameIcon,
                            isRequire: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: MyFormField(
                            controller: _phoneController,
                            labelText: phone,
                            /*validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return phoneError;
                                }
                                return null;
                              },*/
                            icon: phoneIcon,
                            isRequire: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: MyFormField(
                            controller: _emailController,
                            labelText: email,
                            /*validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return emailError;
                                }
                                return null;
                              },*/
                            icon: emailIcon,
                            isRequire: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: MyFormField(
                            controller: _passwordController,
                            labelText: password,
                            /*validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return passwordError;
                                }
                                return null;
                              },*/
                            icon: passwordIcon,
                            isRequire: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: MyFormField(
                            controller: _homeAddressController,
                            labelText: lblHomeAddress,
                            /* validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return locationError;
                                }
                                return null;
                              },*/
                            icon: locationIcon,
                            isRequire: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: InkWell(
                              onTap: () {
                                intUploadIDNumber = 0;
                                getImageFromGallery();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        // flex: 1,
                                        child: _licenseImageFile == null
                                            ? Image.asset(
                                          noImage,
                                          height:
                                          SizeConfig.safeBlockVertical! * 6.6,
                                          width:
                                          SizeConfig.safeBlockHorizontal! * 6.6,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.file(
                                          _licenseImageFile!,
                                          height:
                                          SizeConfig.safeBlockVertical! * 6.6,
                                          width:
                                          SizeConfig.safeBlockHorizontal! * 6.6,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 5),
                                          child: StandardCustomText(
                                              align: TextAlign.start,
                                              fontSize: 14,
                                              maxlines: 2,
                                              label: "Upload Driving License"),
                                        ),
                                      ),
                                      Expanded(
                                        // flex: 1,
                                        child: SvgPicture.asset(
                                          iconUploadImage,
                                          height: SizeConfig.safeBlockVertical! * 3.0,
                                          width: SizeConfig.safeBlockHorizontal! * 3.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: InkWell(
                              onTap: () {
                                intUploadIDNumber = 1;
                                getImageFromGallery();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        // flex: 1,
                                        child: _adhaarImageFile == null
                                            ? Image.asset(
                                          noImage,
                                          height:
                                          SizeConfig.safeBlockVertical! * 6.6,
                                          width:
                                          SizeConfig.safeBlockHorizontal! * 6.6,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.file(
                                          _adhaarImageFile!,
                                          height:
                                          SizeConfig.safeBlockVertical! * 6.6,
                                          width:
                                          SizeConfig.safeBlockHorizontal! * 6.6,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 5),
                                          child: StandardCustomText(
                                              align: TextAlign.start,
                                              fontSize: 14,
                                              maxlines: 2,
                                              label: "Upload Adhaar License"),
                                        ),
                                      ),
                                      Expanded(
                                        // flex: 1,
                                        child: SvgPicture.asset(
                                          iconUploadImage,
                                          height: SizeConfig.safeBlockVertical! * 3.0,
                                          width: SizeConfig.safeBlockHorizontal! * 3.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              if (state is RegisterSuccessState) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // if (!isCompleted) {
                                  //   Navigator.of(context).maybePop(true);
                                  //   registerBloc.close();
                                  //   isCompleted = true;
                                  // }
                                  Navigator.pushReplacementNamed(
                                      context, routeDashboard);
                                });
                              }
                              return MaterialButton(
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (_formKey.currentState!.validate()) {
                                      var connectivityResult =
                                          await (Connectivity()
                                              .checkConnectivity());
                                      if (connectivityResult ==
                                              ConnectivityResult.mobile ||
                                          connectivityResult ==
                                              ConnectivityResult.wifi) {
                                        if (_formKey.currentState!.validate()) {
                                          if (_licenseImageFile != null &&
                                              _adhaarImageFile != null) {
                                            onSignupButtonClicked();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(createMessageSnackBar(
                                                    "Please Upload License and Adhaar Image"));
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(createMessageSnackBar(
                                                errorNoInternet));
                                      }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 15.0, 0.0, 15.0),
                                  color: darkSkyBluePrimaryColor,
                                  splashColor: Theme.of(context).primaryColor,
                                  disabledColor:
                                      Theme.of(context).disabledColor,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: SizeConfig.blockSizeVertical! * 2.7,
                                    child: Center(
                                      child: (state is RegisterInProgressState)
                                          ? SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal! *
                                                  5.5,
                                              child: const CircularProgressIndicator(
                                                  //color: darkSkyBluePrimaryColor,
                                                  ),
                                            )
                                          : const Text(
                                              lblSubmit,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: whiteColor,
                                              ),
                                            ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const StandardCustomText(
                                  label: 'Already have an account? '),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const StandardCustomText(
                                    label: login,
                                    color: darkSkyBluePrimaryColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future getImageFromGallery() async {
    if (Platform.isIOS) {
      final photosPermissionStatus = await Permission.photos.status;
      if (photosPermissionStatus == PermissionStatus.limited) {
        final imageFile = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: configurationService!.maxPictureWidth,
            maxHeight: configurationService!.maxPictureHeight);
        if (imageFile != null) {
          _cropSelectedProfilePictureFile(File(imageFile.path));
        }
      } else {
        PermissionStatus permissionStatus = await _getGalleryPermission();
        if (permissionStatus == PermissionStatus.granted) {
          final imageFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxWidth: configurationService!.maxPictureWidth,
              maxHeight: configurationService!.maxPictureHeight);
          if (imageFile != null) {
            _cropSelectedProfilePictureFile(File(imageFile.path));
          }
        } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
          String? permissionContent =
              "You disabled gallery permission. Please go to phone settings and allow storage access for VCarez.";
          _handleInvalidPermissions(
              permissionStatus, context, permissionContent);
        }
      }
    } else {
      PermissionStatus permissionStatus = await _getGalleryPermission();
      if (permissionStatus == PermissionStatus.granted) {
        final imageFile = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: configurationService!.maxPictureWidth,
            maxHeight: configurationService!.maxPictureHeight);
        if (imageFile != null) {
          _cropSelectedProfilePictureFile(File(imageFile.path));
        }
      } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
        String? permissionContent =
            "You disabled gallery permission. Please go to phone settings and allow storage access for VCarez.";
        _handleInvalidPermissions(permissionStatus, context, permissionContent);
      }
    }
  }

  Future<PermissionStatus> _getGalleryPermission() async {
    PermissionStatus permission;
    if (Platform.isIOS) {
      Map<Permission, PermissionStatus> statuses =
      await [Permission.photos].request();
      permission = statuses.values.toList()[0];
      return permission;
    } else {
      Map<Permission, PermissionStatus> statuses =
      await [Permission.storage].request();
      permission = statuses.values.toList()[0];
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus? permissionStatus,
      BuildContext context, String? permissionContent) async {
    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        displaySettingDialog(context, permissionContent);
      } else {
        displaySettingDialog(context, permissionContent);
        // ScaffoldMessenger.of(context).showSnackBar(createMessageSnackBar(
        //     AppLocalizations.of(context)!.translate("msg_permission_camera")!));
      }
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      /// *Only supported on Android.*
      displaySettingDialog(context, permissionContent);
    } else if (permissionStatus == PermissionStatus.restricted) {
      /// *Only supported on iOS.*
      displaySettingDialog(context, permissionContent);
    }
  }

  Future<bool?> displaySettingDialog(
      BuildContext screenContext, String? permissionContent) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => PopupDialog(
          textAlign: TextAlign.center,
          text: permissionContent,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
          onPressedNo: () {
            Navigator.of(context).pop();
          },
          onPressedYes: () async {
            try {
              Navigator.of(context).pop();
              openAppSettings();
            } catch (e) {}
          },
          yesText: "Enable",
          noText: "Cancel",
        ));
  }

  _cropSelectedProfilePictureFile(File imageFile) async {
    if (imageFile != null) {
      final croppedFile = (await ImageCropper()
          .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
        CropAspectRatioPreset.square
      ], uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: darkSkyBluePrimaryColor,
            toolbarWidgetColor: whiteColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
        )
      ]));

      _updateSelectedProfilePictureFile(File(croppedFile!.path));
    }
  }

  _updateSelectedProfilePictureFile(File? imageFile) {
    if (mounted && imageFile != null) {
      setState(() {
        if (intUploadIDNumber == 0) {
          _licenseImageFile = imageFile;
          intUploadIDNumber = -1;
        } else {
          _adhaarImageFile = imageFile;
          intUploadIDNumber = -1;
        }
      });
    }
  }
  void onSignupButtonClicked() {
    addDeliveryMenRequestModel.strFullName = _userNameController.text;
    addDeliveryMenRequestModel.strPhoneNumber = _phoneController.text;
    addDeliveryMenRequestModel.strAddressLineOne = _homeAddressController.text;
    addDeliveryMenRequestModel.strPassword = _passwordController.text;
    addDeliveryMenRequestModel.strEmailID = _emailController.text;
    addDeliveryMenRequestModel.fileDrivingLicense = _licenseImageFile;
    addDeliveryMenRequestModel.fileAdhaarCard = _adhaarImageFile;

    registerBloc.add(RegisterDataSubmittedEvent(addDeliveryMenRequestModel));
  }
}
