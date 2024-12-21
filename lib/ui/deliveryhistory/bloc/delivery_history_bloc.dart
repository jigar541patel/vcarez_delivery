import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:vcarez_delivery/ui/deliveryhistory/model/delivery_history_model.dart';

import '../../../services/repo/common_repo.dart';
import '../../../storage/shared_pref_const.dart';
import '../../../utils/common_utils.dart';

part 'delivery_history_event.dart';

part 'delivery_history_state.dart';

class DeliveryHistoryBloc
    extends Bloc<DeliveryHistoryEvent, DeliveryHistoryState> {
  DeliveryHistoryBloc() : super(DeliveryHistoryInitial()) {
    // on<DeliveryHistoryEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<GetDeliveryHistoryEvent>((event, emit) async {
      emit(DeliveryHistoryLoading());
      var storage = FlutterSecureStorage();

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      DeliveryHistoryModel responseData =
          await ApiController().getDeliveryHistoryList(token!);

      if (responseData.success == false) {
        CommonUtils.utils.showToast(responseData.message as String);
        emit(ErrorDeliveryHistoryLoading());
      } else if (responseData.success!) {
        emit(DeliveryHistoryDataLoaded(responseData));
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        emit(ErrorDeliveryHistoryLoading());
      }
    });
  }
}
