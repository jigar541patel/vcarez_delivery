import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:vcarez_delivery/ui/dashboard/model/assign_order_model.dart';
import 'package:vcarez_delivery/ui/dashboard/model/new_order_model.dart';
import 'package:vibration/vibration.dart';

import '../../../services/api/api_hitter.dart';
import '../../../services/repo/common_repo.dart';
import '../../../storage/shared_pref_const.dart';
import '../../../utils/common_utils.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<GetCurrentLocationName>((event, emit) async {
      // TODO: implement event handler
      emit(OnLocationLoadingState());
      Position position = await _determinePosition();
      debugPrint("vcarez customer location we have is ${position.latitude}");
      debugPrint("vcarez customer location we have is ${position.latitude}");

      var storage = const FlutterSecureStorage();

      await storage.write(key: keyUserLat, value: position.latitude.toString());
      await storage.write(
          key: keyUserLong, value: position.longitude.toString());

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      debugPrint(
          "vcarez customer location we have is ${placemarks[0].locality!}");
      emit(OnLocationLoadedState(placemarks[0].locality!));
    });

    on<GetNewOrderEvent>((event, emit) async {
      emit(NewOrderLoading());
      var storage = FlutterSecureStorage();

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      String? strLatitude = await storage.read(key: keyUserLat);
      String? strLongitude = await storage.read(key: keyUserLong);
      NewOrderModel responseData = await ApiController()
          .getNewOrderList(token!, strLatitude!, strLongitude!);

      if (responseData.success == false) {
        CommonUtils.utils.showToast(responseData.message as String);
        emit(ErrorNewLoading());
      } else if (responseData.success!) {
        emit(NewOrderDataLoaded(responseData));
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        emit(ErrorNewLoading());
      }
    });

    on<AcceptOrderEvent>((event, emit) async {
      emit(AcceptOrderLoadingState());
      var storage = const FlutterSecureStorage();
      var requestBody = {
        "sub_order_id": event.orderID,
      };

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      // debugPrint("vcarez customer event.strID! token have is ${event.doubleLongitude}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${event.strQuantity}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${requestBody.toString()}");
      ApiResponse responseData =
          await ApiController().acceptDeliveryOrder(token!, requestBody);

      if (responseData.success) {
        // CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez OnBannerLoaded emited ");
        Fluttertoast.showToast(msg: responseData.message);
        emit(AcceptOrderSuccessState());
        Vibration.vibrate(duration: 1000);
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez ErrorDataLoading emited ");
        emit(ErrorAcceptOrderLoading());
      }
    });

    on<ExtraTimeOrderEvent>((event, emit) async {
      emit(NeedMoreTimeLoadingState());
      var storage = const FlutterSecureStorage();
      var requestBody = {
        "extra_time": true,
      };

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      // debugPrint("vcarez customer event.strID! token have is ${event.doubleLongitude}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${event.strQuantity}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${requestBody.toString()}");
      ApiResponse responseData = await ApiController()
          .needExtraTime(token!, requestBody, event.orderID.toString());

      if (responseData.success) {
        // CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez OnBannerLoaded emited ");
        Fluttertoast.showToast(msg: responseData.message);
        emit(NeedMoreTimeSuccessState());
        Vibration.vibrate(duration: 1000);
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez ErrorDataLoading emited ");
        emit(ErrorNeedMoreTimeLoading());
      }
    });
    on<OrderPickedEvent>((event, emit) async {
      emit(PickedOrderLoadingState());
      var storage = const FlutterSecureStorage();
      var requestBody = {"order_status": 3};

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      // debugPrint("vcarez customer event.strID! token have is ${event.doubleLongitude}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${event.strQuantity}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${requestBody.toString()}");
      ApiResponse responseData = await ApiController()
          .pickedOrder(token!, requestBody, event.orderID.toString());

      if (responseData.success) {
        // CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez OnBannerLoaded emited ");
        Fluttertoast.showToast(msg: responseData.message);
        emit(PickedOrderSuccessState());
        Vibration.vibrate(duration: 1000);
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez ErrorDataLoading emited ");
        emit(ErrorPickedOrderTimeLoading());
      }
    });
    on<OrderDeliveredEvent>((event, emit) async {
      emit(DeliveredOrderLoadingState());
      var storage = const FlutterSecureStorage();
      var requestBody = {"order_status": 4};

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      // debugPrint("vcarez customer event.strID! token have is ${event.doubleLongitude}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${event.strQuantity}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${requestBody.toString()}");
      ApiResponse responseData = await ApiController()
          .pickedOrder(token!, requestBody, event.orderID.toString());

      if (responseData.success) {
        // CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez OnBannerLoaded emited ");
        Fluttertoast.showToast(msg: responseData.message);
        emit(DeliveredOrderSuccessState());
        Vibration.vibrate(duration: 1000);
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez ErrorDataLoading emited ");
        emit(ErrorDeliveredOrderLoading());
      }
    });

    on<RejectOrderEvent>((event, emit) async {
      emit(RejectOrderLoadingState());
      var storage = const FlutterSecureStorage();
      var requestBody = {
        "sub_order_id": event.orderID,
      };

      String? token = await storage.read(key: keyUserToken);
      debugPrint("vcarez customer reading access token have is $token");
      // debugPrint("vcarez customer event.strID! token have is ${event.doubleLongitude}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${event.strQuantity}");
      // debugPrint(
      //     "vcarez customer event.strQuantity! token have is ${requestBody.toString()}");
      ApiResponse responseData =
          await ApiController().rejectDeliveryOrder(token!, requestBody);

      if (responseData.success) {
        // CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez OnBannerLoaded emited ");
        Fluttertoast.showToast(msg: responseData.message);
        emit(RejectOrderSuccessState());
        Vibration.vibrate(duration: 1000);
      } else {
        CommonUtils.utils.showToast(responseData.message as String);
        debugPrint("vcarez ErrorDataLoading emited ");
        emit(ErrorRejectOrderLoading());
      }
    });
  }

  Future<Position> _determinePosition() async {
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
