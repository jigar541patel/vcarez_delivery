import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../services/repo/common_repo.dart';
import '../../../storage/shared_pref_const.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/strings.dart';
import '../model/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // on<LoginEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<LoginSubmittedEvent>((event, emit) async {
      debugPrint("vcarez customer login submit bloc called ");

      emit.call(AddingDataInProgressState());

      var requestBody = {
        "email": event.strEmail,
        "password": event.strPassword,
      };

      var responseData = await ApiController().userLogin(requestBody);
      // showLoader.value = false;
      debugPrint("vcarez customer we have is $responseData");

      if (responseData.success) {
        LoginModel loginModel = responseData;
        CommonUtils.utils.showToast(successLogin);
        emit.call(AddingDataValidCompletedState());
        var storage = FlutterSecureStorage();

        debugPrint(
            "vcarez customer access token have is ${loginModel.token!.original!.accessToken}");
        await storage.write(
            key: keyUserToken, value: loginModel.token!.original!.accessToken);

        //stored in SharedPrefConstant.dart
        // storage.write(userData, responseData.result);
        // storage.write(userPassword, passwordController.text);
        // storage.write(userPassword, passwordController.text);
        // GlobalVariables.userToken = responseData.token!;
        // passwordController.clear();
        // Get.to(() => LoginLocationScreen());

      } else {
        emit.call(AddingDataInValidCompletedState());
        CommonUtils.utils.showToast(
          // responseData.status as int+
            responseData.message as String);
      }
    });
  }
}
