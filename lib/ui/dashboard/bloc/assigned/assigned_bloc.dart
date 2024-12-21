import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../../services/repo/common_repo.dart';
import '../../../../storage/shared_pref_const.dart';
import '../../../../utils/common_utils.dart';
import '../../model/assign_order_model.dart';

part 'assigned_event.dart';

part 'assigned_state.dart';

class AssignedBloc extends Bloc<AssignedEvent, AssignedState> {
  AssignedBloc() : super(AssignedInitial()) {
    on<GetAssignOrderEvent>((event, emit) async {
      emit(AssignOrderLoading());
      var storage = FlutterSecureStorage();

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      AssignOrderModel responseData =
          await ApiController().getAssignOrderList(token!);

      if (responseData.success == false) {
        CommonUtils.utils.showToast(responseData.message as String);
        emit(ErrorAssignOrderLoading());
      } else if (responseData.success!) {
        emit(AssignOrderDataLoaded(responseData));
      }
      // else {
      //   CommonUtils.utils.showToast(responseData.message as String);
      //   emit(ErrorAssignOrderLoading());
      // }
    });
  }
}
