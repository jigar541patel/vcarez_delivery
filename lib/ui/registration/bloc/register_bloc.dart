import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:vcarez_delivery/ui/registration/model/register_model.dart';

import '../../../services/api/api_hitter.dart';
import '../../../services/repo/common_repo.dart';
import '../../../storage/shared_pref_const.dart';
import '../../../utils/common_utils.dart';
import '../model/add_delivery_man_request_model.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    // on<RegisterDataSubmittedEvent>((event, emit) {
    // TODO: implement event handler

    on<RegisterDataSubmittedEvent>((event, emit) async {
      emit.call(RegisterInProgressState());
      // yield AddingDataInProgressState();
      // var requestBody = {
      //   "email": event.strEmail,
      //   "password": event.strPassword,
      // };
      var loginFormData = FormData.fromMap({
        "name": event.addDeliveryMenRequestModel.strFullName,
        "email": event.addDeliveryMenRequestModel.strEmailID,
        "phone": event.addDeliveryMenRequestModel.strPhoneNumber,
        "password": event.addDeliveryMenRequestModel.strPassword,
        "address": event.addDeliveryMenRequestModel.strAddressLineOne,
        "license": await MultipartFile.fromFile(
            event.addDeliveryMenRequestModel.fileDrivingLicense!.path,
            filename: event.addDeliveryMenRequestModel.fileDrivingLicense!.path
                .split('/')
                .last
                .toLowerCase(),
            contentType: MediaType("image", "jpg")),
        "aadhar": await MultipartFile.fromFile(
            event.addDeliveryMenRequestModel.fileAdhaarCard!.path,
            filename: event.addDeliveryMenRequestModel.fileAdhaarCard!.path
                .split('/')
                .last
                .toLowerCase(),
            contentType: MediaType("image", "jpg")),
      });
      var storage = const FlutterSecureStorage();

      // String? token = await storage.read(key: keyUserToken);
      // debugPrint(
      //     "vcarez vendor bussiness read detail access token have is $token");
      // debugPrint("vcarez registerRequestModel.strShopImage!.path have is " +
      //     event.registerRequestModel.strShopImage!.path);
      // debugPrint("vcarez vendor business detail we have is " +
      //     loginFormData.toString());

      RegisterModel responseData =
          await ApiController().userSignUp( loginFormData);

      debugPrint("vcarez vendor business detail we have is $responseData");

      if (responseData.success!) {
        CommonUtils.utils.showToast(responseData.message!);

        // RegisterModel registerModel=RegisterModel.fromJson(responseData.response!.data);

        debugPrint(
            "vcarez dleivery access token have is ${responseData.token!.original!.accessToken}");
        await storage.write(
            key: keyUserToken,
            value: responseData.token!.original!.accessToken);

        emit.call(RegisterSuccessState(responseData));
      } else {
        CommonUtils.utils.showToast(
            // responseData.status as int+
            responseData.message as String);
        emit.call(RegisterErrorState());
      }
    });
    // });
  }
}
