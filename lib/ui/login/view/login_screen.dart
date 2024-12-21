import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vcarez_delivery/components/SizeConfig.dart';
import 'package:vcarez_delivery/ui/login/bloc/login_bloc.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../components/my_form_field.dart';
import '../../../components/my_theme_button.dart';
import '../../../components/standard_regular_text.dart';
import '../../../utils/route_names.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../../../utils/colors_utils.dart';
import '../../../utils/images_utils.dart';
import '../../../utils/strings.dart';
import '../../forgot_password_screen.dart';
import '../../registration/view/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _userNameController, _passwordController;

  LoginBloc loginBloc = LoginBloc();

  void initController() {
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController.text="jigartest52@gmail.com";
    _passwordController.text="123456";
  }

  void disposeController() {
    _userNameController.dispose();
    _passwordController.dispose();
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
          child: BlocProvider(
        create: (context) => loginBloc,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const StandardCustomText(
                          label: login,
                          fontWeight: FontWeight.bold,
                          color: darkSkyBluePrimaryColor,
                          fontSize: 30.0,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        const StandardCustomText(
                          label: loginSubtitle,
                          color: descriptionTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          child: MyFormField(
                            controller: _userNameController,
                            labelText: username,
                            /* validator: (value) {
                            if (value == null || value.isEmpty) {
                              return usernameError;
                            }
                            return null;
                          },*/
                            icon: usernameIcon,
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
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()),
                              );
                            },
                            child: const StandardCustomText(
                              label: forgotPasswordQ,
                              style: TextStyle(
                                color: darkSkyBluePrimaryColor,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is AddingDataValidCompletedState) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
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
                                        onLoginButtonClicked();
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
                                      child:
                                          (state is AddingDataInProgressState)
                                              ? SizedBox(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal! *
                                                      5.5,
                                                  child: CircularProgressIndicator(
                                                      //color: darkSkyBluePrimaryColor,
                                                      ),
                                                )
                                              : Text(
                                                  login,
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
                                  label: 'Don\'t have an account? '),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen()),
                                    );
                                  },
                                  child: const StandardCustomText(
                                    label: ' Sign up',
                                    fontWeight: FontWeight.bold,
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
            )
          ],
        ),
      )),
    );
  }

  void onLoginButtonClicked() {
    loginBloc.add(LoginSubmittedEvent(
        _userNameController.text, _passwordController.text));
  }
}
