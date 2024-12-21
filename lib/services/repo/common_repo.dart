import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vcarez_delivery/ui/dashboard/model/assign_order_model.dart';
import 'package:vcarez_delivery/ui/dashboard/model/new_order_model.dart';
import 'package:vcarez_delivery/ui/deliveryhistory/model/delivery_history_model.dart';
import 'package:vcarez_delivery/ui/registration/model/register_model.dart';

// import 'package:vcarez_new/ui/login/model/login_model.dart';
// import 'package:vcarez_new/ui/profile/model/profile_model.dart';

import '../../base/base_repository.dart';

// import '../../ui/signup/model/signup_model.dart';

import '../../ui/login/model/login_model.dart';
import '../../ui/profile/model/profile_model.dart';
import '../api/api_end_point.dart';
import '../api/api_hitter.dart';

class ApiController extends BaseRepository {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status${e.message}');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    // setState(() {
    _connectionStatus = result;
    // });
  }

  Future<dynamic> forgotPassword(var loginFormData) async {
    initConnectivity();

    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter
        .getPostApiResponse(ApiEndpoint.forgotPassword, data: loginFormData);

    {
      try {
        if (apiResponse.success) {
          if (apiResponse.response!.data != null) {
            // debugPrint("vcarez the forgotPassword rrsponsecode== is " +
            //     apiResponse.responseCode.toString());
            if (apiResponse.responseCode) {
              return ApiResponse(true,
                  responseCode: apiResponse.responseCode,
                  message: apiResponse.response!.data['message']);
            } else {
              return ApiResponse(false,
                  responseCode: apiResponse.responseCode,
                  message: apiResponse.response!.data['message']);
            }
          } else {
            return apiResponse;
            // return LoginModel(
            //     token: apiResponse.response!.data,
            //     success: apiResponse.success);
          }
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<dynamic> verifyOtpPassword(var loginFormData) async {
    initConnectivity();

    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter
        .getPostApiResponse(ApiEndpoint.updatePassword, data: loginFormData);
    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          if (apiResponse.response!.data != null) {
            if (apiResponse.responseCode) {
              return ApiResponse(true,
                  responseCode: apiResponse.responseCode,
                  message: apiResponse.response!.data['message']);
            } else {
              return ApiResponse(false,
                  responseCode: apiResponse.responseCode,
                  message: apiResponse.response!.data['message']);
            }
          } else {
            return apiResponse;
            // return LoginModel(
            //     token: apiResponse.response!.data,
            //     success: apiResponse.success);
          }
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<dynamic> acceptDeliveryOrder(
      String userToken, var loginFormData) async {
    initConnectivity();
    var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
      "${ApiEndpoint.acceptOrderList}",
      headers: auth,
      data: loginFormData,
    );
    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }
  Future<dynamic> needExtraTime(
      String userToken, var loginFormData, String? strOrderID) async {
    initConnectivity();
    var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter.getPutApiJson(
        "${ApiEndpoint.getMyOrderList}/$strOrderID",
        headers: auth,
        data: loginFormData);
    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }
  Future<dynamic> pickedOrder(
      String userToken, var loginFormData, String? strOrderID) async {
    initConnectivity();
    var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter.getPutApiJson(
        "${ApiEndpoint.getMyOrderList}/$strOrderID",
        headers: auth,
        data: loginFormData);
    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<dynamic> rejectDeliveryOrder(
      String userToken, var loginFormData) async {
    initConnectivity();
    var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
      "${ApiEndpoint.rejectOrderList}",
      headers: auth,
      data: loginFormData,
    );
    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<dynamic> userLogin(var loginFormData) async {
    initConnectivity();

    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse = await apiHitter
        .getPostApiResponse(ApiEndpoint.userLogin, data: loginFormData);
    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          if (apiResponse.response!.data != null) {
            final passEntity = LoginModel.fromJson(apiResponse.response!.data);
            return passEntity;
          } else {
            return apiResponse;
            // return LoginModel(
            //     token: apiResponse.response!.data,
            //     success: apiResponse.success);
          }
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<AssignOrderModel> getAssignOrderList(String userToken,
      {Map<String, String>? requestBody}) async {
    var auth = {"Authorization": 'Bearer $userToken'};

    ApiResponse apiResponse =
        await apiHitter.getApiResponse(ApiEndpoint.getAssignOrderList,
            // +
            // "?latitude=22.814750&longitude=88.860259",
            headers: auth,
            queryParams: requestBody);

    try {
      // if (apiResponse.responseCode == 403) {
      //   return ProfileModel(
      //       success: false, message: apiResponse.message, driver: null);
      // }
      //
      if (apiResponse.success) {
        if (apiResponse.response != null) {
          if (apiResponse.response!.data != null) {
            final passEntity =
                AssignOrderModel.fromJson(apiResponse.response!.data);
            debugPrint(
                "vcarez delivery pass entity access token have is ${passEntity.success}");
            debugPrint(
                "vcarez delivery passEntity.orders.toString() token have is ${passEntity.orders!.length.toString()}");

            return passEntity;
          } else {
            if (apiResponse.responseCode == 403) {
              return AssignOrderModel(
                  success: false, message: apiResponse.message, orders: null);
            } else {
              return AssignOrderModel(
                  success: apiResponse.success,
                  message: apiResponse.message,
                  orders: null);
            }
          }
        } else {
          if (apiResponse.responseCode == 403) {
            return AssignOrderModel(
                success: false, message: apiResponse.message, orders: null);
          } else {
            return AssignOrderModel(
                success: apiResponse.success,
                message: apiResponse.message,
                orders: null);
          }
        }
      } else {
        if (apiResponse.responseCode == 403) {
          return AssignOrderModel(
              success: false, message: apiResponse.message, orders: null);
        } else {
          return AssignOrderModel(
              success: apiResponse.success,
              message: apiResponse.message,
              orders: null);
        }
      }
    } catch (error) {
      return AssignOrderModel(
          success: false,
          message: apiResponse.message + " error code : " + error.toString(),
          orders: null);
    }
  }

  Future<NewOrderModel> getNewOrderList(
      String userToken, String latitude, String longitude,
      {Map<String, String>? requestBody}) async {
    var auth = {"Authorization": 'Bearer $userToken'};

    ApiResponse apiResponse = await apiHitter.getApiResponse(
        "${ApiEndpoint.getMyOrderList}?latitude=$latitude&longitude=$longitude",
        headers: auth,
        queryParams: requestBody);

    try {
      // if (apiResponse.responseCode == 403) {
      //   return ProfileModel(
      //       success: false, message: apiResponse.message, driver: null);
      // }
      //
      if (apiResponse.success) {
        if (apiResponse.response != null) {
          if (apiResponse.response!.data != null) {
            final passEntity =
                NewOrderModel.fromJson(apiResponse.response!.data);
            debugPrint(
                "vcarez delivery pass entity access token have is ${passEntity.success}");

            return passEntity;
          } else {
            if (apiResponse.responseCode == 403) {
              return NewOrderModel(
                  success: false, message: apiResponse.message, orders: null);
            } else {
              return NewOrderModel(
                  success: apiResponse.success,
                  message: apiResponse.message,
                  orders: null);
            }
          }
        } else {
          if (apiResponse.responseCode == 403) {
            return NewOrderModel(
                success: false, message: apiResponse.message, orders: null);
          } else {
            return NewOrderModel(
                success: apiResponse.success,
                message: apiResponse.message,
                orders: null);
          }
        }
      } else {
        if (apiResponse.responseCode == 403) {
          return NewOrderModel(
              success: false, message: apiResponse.message, orders: null);
        } else {
          return NewOrderModel(
              success: apiResponse.success,
              message: apiResponse.message,
              orders: null);
        }
      }
    } catch (error) {
      return NewOrderModel(
          success: false,
          message: apiResponse.message + " error code : " + error.toString(),
          orders: null);
    }
  }


  Future<DeliveryHistoryModel> getDeliveryHistoryList(
      String userToken,
      {Map<String, String>? requestBody}) async {
    var auth = {"Authorization": 'Bearer $userToken'};

    ApiResponse apiResponse = await apiHitter.getApiResponse(
        ApiEndpoint.getDeliveryOrderList,
        headers: auth,
        queryParams: requestBody);

    try {
      // if (apiResponse.responseCode == 403) {
      //   return ProfileModel(
      //       success: false, message: apiResponse.message, driver: null);
      // }
      //
      if (apiResponse.success) {
        if (apiResponse.response != null) {
          if (apiResponse.response!.data != null) {
            final passEntity =
                DeliveryHistoryModel.fromJson(apiResponse.response!.data);
            debugPrint(
                "vcarez delivery pass entity access token have is ${passEntity.success}");

            return passEntity;
          } else {
            if (apiResponse.responseCode == 403) {
              return DeliveryHistoryModel(
                  success: false, message: apiResponse.message, orders: null);
            } else {
              return DeliveryHistoryModel(
                  success: apiResponse.success,
                  message: apiResponse.message,
                  orders: null);
            }
          }
        } else {
          if (apiResponse.responseCode == 403) {
            return DeliveryHistoryModel(
                success: false, message: apiResponse.message, orders: null);
          } else {
            return DeliveryHistoryModel(
                success: apiResponse.success,
                message: apiResponse.message,
                orders: null);
          }
        }
      } else {
        if (apiResponse.responseCode == 403) {
          return DeliveryHistoryModel(
              success: false, message: apiResponse.message, orders: null);
        } else {
          return DeliveryHistoryModel(
              success: apiResponse.success,
              message: apiResponse.message,
              orders: null);
        }
      }
    } catch (error) {
      return DeliveryHistoryModel(
          success: false,
          message: apiResponse.message + " error code : " + error.toString(),
          orders: null);
    }
  }

  Future<ProfileModel> getUserProfile(String userToken,
      {Map<String, String>? requestBody}) async {
    var auth = {"Authorization": 'Bearer $userToken'};

    ApiResponse apiResponse = await apiHitter.getApiResponse(
        ApiEndpoint.getUserprofile,
        headers: auth,
        queryParams: requestBody);

    try {
      // if (apiResponse.responseCode == 403) {
      //   return ProfileModel(
      //       success: false, message: apiResponse.message, driver: null);
      // }
      //
      if (apiResponse.success) {
        if (apiResponse.response != null) {
          if (apiResponse.response!.data != null) {
            final passEntity =
                ProfileModel.fromJson(apiResponse.response!.data);
            debugPrint(
                "vcarez delivery pass entity access token have is ${passEntity.success}");

            return passEntity;
          } else {
            if (apiResponse.responseCode == 403) {
              return ProfileModel(
                  success: false, message: apiResponse.message, driver: null);
            } else {
              return ProfileModel(
                  success: apiResponse.success,
                  message: apiResponse.message,
                  driver: null);
            }
          }
        } else {
          if (apiResponse.responseCode == 403) {
            return ProfileModel(
                success: false, message: apiResponse.message, driver: null);
          } else {
            return ProfileModel(
                success: apiResponse.success,
                message: apiResponse.message,
                driver: null);
          }
        }
      } else {
        if (apiResponse.responseCode == 403) {
          return ProfileModel(
              success: false, message: apiResponse.message, driver: null);
        } else {
          return ProfileModel(
              success: apiResponse.success,
              message: apiResponse.message,
              driver: null);
        }
      }
    } catch (error) {
      return ProfileModel(
          success: false,
          message: apiResponse.message + " error code : " + error.toString(),
          driver: null);
    }
  }

  // Future<dynamic> userLogin(var loginFormData) async {
  //   initConnectivity();
  //
  //   debugPrint("vcarez the internet is ${_connectionStatus.name}");
  //   ApiResponse apiResponse = await apiHitter
  //       .getPostApiResponse(ApiEndpoint.userLogin, data: loginFormData);
  //   {
  //     try {
  //       if (apiResponse.success) {
  //         debugPrint("vcarez the try first is${apiResponse.response!.data}");
  //
  //         if (apiResponse.response!.data != null) {
  //           final passEntity = LoginModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           return apiResponse;
  //           // return LoginModel(
  //           //     token: apiResponse.response!.data,
  //           //     success: apiResponse.success);
  //         }
  //       } else {
  //         return apiResponse;
  //       }
  //     } catch (error) {
  //       debugPrint("vcarez the error is $apiResponse");
  //       // return LoginModel(
  //       //     token: apiResponse.toString(), success: false);
  //     }
  //   }
  // }
  //
  // Future<SearchResultModel> getSearchMedicineList(
  //     String userToken, String searchQuery,
  //     {Map<String, String>? requestBody}) async {
  //   var auth = {"Authorization": 'Bearer $userToken'};
  //
  //   ApiResponse apiResponse = await apiHitter.getApiResponse(
  //       ApiEndpoint.getMedicineSearchList + "?search=" + searchQuery,
  //       headers: auth,
  //       queryParams: requestBody);
  //
  //   debugPrint("vcarez the getSearchMedicineList api status is " +
  //       apiResponse.responseCode.toString());
  //   debugPrint("vcarez the getSearchMedicineList api data is " +
  //       apiResponse.response!.data.toString());
  //
  //   try {
  //     if (apiResponse.responseCode == null) {
  //       if (apiResponse.message.contains("Medicines fetched successfully")) {
  //         final passEntity =
  //             SearchResultModel.fromJson(apiResponse.response!.data);
  //         return passEntity;
  //       }
  //     }
  //     if (apiResponse.responseCode == 403) {
  //       return SearchResultModel(
  //           success: false, message: apiResponse.message, medicines: null);
  //     }
  //     if (apiResponse.success) {
  //       if (apiResponse.response != null) {
  //         if (apiResponse.response!.data != null) {
  //           final passEntity =
  //               SearchResultModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           if (apiResponse.responseCode == 403) {
  //             return SearchResultModel(
  //                 success: false,
  //                 message: apiResponse.message,
  //                 medicines: null);
  //           } else {
  //             return SearchResultModel(
  //                 success: apiResponse.success,
  //                 message: apiResponse.message,
  //                 medicines: null);
  //           }
  //         }
  //       } else {
  //         if (apiResponse.responseCode == 403) {
  //           return SearchResultModel(
  //               success: false, message: apiResponse.message, medicines: null);
  //         } else {
  //           return SearchResultModel(
  //               success: apiResponse.success,
  //               message: apiResponse.message,
  //               medicines: null);
  //         }
  //       }
  //     } else {
  //       if (apiResponse.responseCode == 403) {
  //         return SearchResultModel(
  //             success: false, message: apiResponse.message, medicines: null);
  //       } else {
  //         return SearchResultModel(
  //             success: apiResponse.success,
  //             message: apiResponse.message,
  //             medicines: null);
  //       }
  //     }
  //   } catch (error) {
  //     return SearchResultModel(
  //         success: false, message: apiResponse.message, medicines: null);
  //   }
  // }
  //
  // Future<MyOrderListModel> getMyOrderList(String userToken,
  //     {Map<String, String>? requestBody}) async {
  //   var auth = {"Authorization": 'Bearer $userToken'};
  //
  //   ApiResponse apiResponse = await apiHitter.getApiResponse(
  //       ApiEndpoint.getMyOrderList,
  //       headers: auth,
  //       queryParams: requestBody);
  //
  //   try {
  //     if (apiResponse.responseCode == 403) {
  //       return MyOrderListModel(
  //           success: false, message: apiResponse.message, orders: null);
  //     }
  //     if (apiResponse.success) {
  //       if (apiResponse.response != null) {
  //         if (apiResponse.response!.data != null) {
  //           final passEntity =
  //               MyOrderListModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           if (apiResponse.responseCode == 403) {
  //             return MyOrderListModel(
  //                 success: false, message: apiResponse.message, orders: null);
  //           } else {
  //             return MyOrderListModel(
  //                 success: apiResponse.success,
  //                 message: apiResponse.message,
  //                 orders: null);
  //           }
  //         }
  //       } else {
  //         if (apiResponse.responseCode == 403) {
  //           return MyOrderListModel(
  //               success: false, message: apiResponse.message, orders: null);
  //         } else {
  //           return MyOrderListModel(
  //               success: apiResponse.success,
  //               message: apiResponse.message,
  //               orders: null);
  //         }
  //       }
  //     } else {
  //       if (apiResponse.responseCode == 403) {
  //         return MyOrderListModel(
  //             success: false, message: apiResponse.message, orders: null);
  //       } else {
  //         return MyOrderListModel(
  //             success: apiResponse.success,
  //             message: apiResponse.message,
  //             orders: null);
  //       }
  //     }
  //   } catch (error) {
  //     return MyOrderListModel(
  //         success: false, message: apiResponse.message, orders: null);
  //   }
  // }
  //
  // Future<QuotationHistoryListModel> getBidCornerList(
  //     String userToken, var latitude, var longitude,
  //     {Map<String, String>? requestBody}) async {
  //   var auth = {"Authorization": 'Bearer $userToken'};
  //
  //   ApiResponse apiResponse = await apiHitter.getApiResponse(
  //       ApiEndpoint.getBidCornerList +
  //           "?latitude=" +
  //           latitude +
  //           "&longitude=" +
  //           longitude,
  //       headers: auth,
  //       queryParams: requestBody);
  //
  //   try {
  //     if (apiResponse.responseCode == 403) {
  //       return QuotationHistoryListModel(
  //           success: false,
  //           message: apiResponse.message,
  //           customerMedicineOrderList: null);
  //     }
  //     if (apiResponse.success) {
  //       if (apiResponse.response != null) {
  //         if (apiResponse.response!.data != null) {
  //           final passEntity =
  //               QuotationHistoryListModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           if (apiResponse.responseCode == 403) {
  //             return QuotationHistoryListModel(
  //                 success: false,
  //                 message: apiResponse.message,
  //                 customerMedicineOrderList: null);
  //           } else {
  //             return QuotationHistoryListModel(
  //                 success: apiResponse.success,
  //                 message: apiResponse.message,
  //                 customerMedicineOrderList: null);
  //           }
  //         }
  //       } else {
  //         if (apiResponse.responseCode == 403) {
  //           return QuotationHistoryListModel(
  //               success: false,
  //               message: apiResponse.message,
  //               customerMedicineOrderList: null);
  //         } else {
  //           return QuotationHistoryListModel(
  //               success: apiResponse.success,
  //               message: apiResponse.message,
  //               customerMedicineOrderList: null);
  //         }
  //       }
  //     } else {
  //       if (apiResponse.responseCode == 403) {
  //         return QuotationHistoryListModel(
  //             success: false,
  //             message: apiResponse.message,
  //             customerMedicineOrderList: null);
  //       } else {
  //         return QuotationHistoryListModel(
  //             success: apiResponse.success,
  //             message: apiResponse.message,
  //             customerMedicineOrderList: null);
  //       }
  //     }
  //   } catch (error) {
  //     return QuotationHistoryListModel(
  //         success: false,
  //         message: apiResponse.message,
  //         customerMedicineOrderList: null);
  //   }
  // }

  // Future<QuotationDetailModel> getQuotationDetail(
  //     String userToken, String strID,
  //     {Map<String, String>? requestBody}) async {
  //   var auth = {"Authorization": 'Bearer $userToken'};
  //
  //   ApiResponse apiResponse = await apiHitter.getApiResponse(
  //       ApiEndpoint.getQuotationDetail + strID,
  //       headers: auth,
  //       queryParams: requestBody);
  //
  //   try {
  //     debugPrint(
  //         "vcarez vendor getMedicineDetail apiResponse.responseCode is ${apiResponse.responseCode}");
  //     if (apiResponse.responseCode == 403) {
  //       return QuotationDetailModel(
  //           success: false, message: apiResponse.message, quotation: null);
  //     }
  //     if (apiResponse.success) {
  //       if (apiResponse.response != null) {
  //         if (apiResponse.response!.data != null) {
  //           final passEntity =
  //               QuotationDetailModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           if (apiResponse.responseCode == 403) {
  //             return QuotationDetailModel(
  //                 success: false,
  //                 message: apiResponse.message,
  //                 quotation: null);
  //           } else {
  //             return QuotationDetailModel(
  //                 success: false,
  //                 message: apiResponse.message,
  //                 quotation: null);
  //           }
  //         }
  //       } else {
  //         if (apiResponse.responseCode == 403) {
  //           return QuotationDetailModel(
  //               success: false, message: apiResponse.message, quotation: null);
  //         } else {
  //           return QuotationDetailModel(
  //               success: false, message: apiResponse.message, quotation: null);
  //         }
  //       }
  //     } else {
  //       if (apiResponse.responseCode == 403) {
  //         return QuotationDetailModel(
  //             success: false, message: apiResponse.message, quotation: null);
  //       } else {
  //         return QuotationDetailModel(
  //             success: false, message: apiResponse.message, quotation: null);
  //       }
  //     }
  //   } catch (error) {
  //     return QuotationDetailModel(
  //         success: false, message: apiResponse.message, quotation: null);
  //   }
  // }
  //
  // Future<MedicineDetailsModel> getMedicineDetail(String userToken, String strID,
  //     {Map<String, String>? requestBody}) async {
  //   var auth = {"Authorization": 'Bearer $userToken'};
  //
  //   ApiResponse apiResponse = await apiHitter.getApiResponse(
  //       ApiEndpoint.getMedicineDetail + strID,
  //       headers: auth,
  //       queryParams: requestBody);
  //
  //   try {
  //     debugPrint(
  //         "vcarez vendor getMedicineDetail apiResponse.responseCode is ${apiResponse.responseCode}");
  //     if (apiResponse.responseCode == 403) {
  //       return MedicineDetailsModel(
  //           success: false, message: apiResponse.message, medicine: null);
  //     }
  //     if (apiResponse.success) {
  //       if (apiResponse.response != null) {
  //         if (apiResponse.response!.data != null) {
  //           final passEntity =
  //               MedicineDetailsModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           if (apiResponse.responseCode == 403) {
  //             return MedicineDetailsModel(
  //                 success: false, message: apiResponse.message, medicine: null);
  //           } else {
  //             return MedicineDetailsModel(
  //                 success: false, message: apiResponse.message, medicine: null);
  //           }
  //         }
  //       } else {
  //         if (apiResponse.responseCode == 403) {
  //           return MedicineDetailsModel(
  //               success: false, message: apiResponse.message, medicine: null);
  //         } else {
  //           return MedicineDetailsModel(
  //               success: false, message: apiResponse.message, medicine: null);
  //         }
  //       }
  //     } else {
  //       if (apiResponse.responseCode == 403) {
  //         return MedicineDetailsModel(
  //             success: false, message: apiResponse.message, medicine: null);
  //       } else {
  //         return MedicineDetailsModel(
  //             success: false, message: apiResponse.message, medicine: null);
  //       }
  //     }
  //   } catch (error) {
  //     return MedicineDetailsModel(
  //         success: false, message: apiResponse.message, medicine: null);
  //   }
  // }
  //
  // Future<ProfileModel> getUserProfile(String userToken,
  //     {Map<String, String>? requestBody}) async {
  //   var auth = {"Authorization": 'Bearer $userToken'};
  //
  //   ApiResponse apiResponse = await apiHitter.getApiResponse(
  //       ApiEndpoint.getUserprofile,
  //       headers: auth,
  //       queryParams: requestBody);
  //
  //   try {
  //     if (apiResponse.responseCode == 403) {
  //       return ProfileModel(
  //           success: false, message: apiResponse.message, vendor: null);
  //     }
  //     if (apiResponse.success) {
  //       if (apiResponse.response != null) {
  //         if (apiResponse.response!.data != null) {
  //           final passEntity =
  //               ProfileModel.fromJson(apiResponse.response!.data);
  //           return passEntity;
  //         } else {
  //           if (apiResponse.responseCode == 403) {
  //             return ProfileModel(
  //                 success: false, message: apiResponse.message, vendor: null);
  //           } else {
  //             return ProfileModel(
  //                 success: apiResponse.success,
  //                 message: apiResponse.message,
  //                 vendor: null);
  //           }
  //         }
  //       } else {
  //         if (apiResponse.responseCode == 403) {
  //           return ProfileModel(
  //               success: false, message: apiResponse.message, vendor: null);
  //         } else {
  //           return ProfileModel(
  //               success: apiResponse.success,
  //               message: apiResponse.message,
  //               vendor: null);
  //         }
  //       }
  //     } else {
  //       if (apiResponse.responseCode == 403) {
  //         return ProfileModel(
  //             success: false, message: apiResponse.message, vendor: null);
  //       } else {
  //         return ProfileModel(
  //             success: apiResponse.success,
  //             message: apiResponse.message,
  //             vendor: null);
  //       }
  //     }
  //   } catch (error) {
  //     return ProfileModel(
  //         success: false, message: apiResponse.message, vendor: null);
  //   }
  // }

  Future<RegisterModel> userSignUp(FormData? formData) async {
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
        ApiEndpoint.userRegister,
        postFormData: formData,
        isFormData: true);
    {
      try {
        debugPrint("vcarez the try first is${apiResponse.message}");
        if (apiResponse.success) {
          final passEntity = RegisterModel.fromJson(apiResponse.response!.data);
          return passEntity;
        } else {
          return RegisterModel(
              message: apiResponse.message,
              success: apiResponse.success,
              token: null);
        }
        //   } else {
        //     return SignupModel(
        //         message: apiResponse.message, success: apiResponse.success);
        //   }
        // } else {
        //   return ApiResponse(false,
        //       responseCode: apiResponse.responseCode,
        //       message: apiResponse.message);
        // }
      } catch (error) {
        debugPrint("vcarez the register error is $apiResponse");
      }

      return RegisterModel(
          message: apiResponse.message,
          success: apiResponse.success,
          token: null);
    }
  }

  Future<dynamic> makeBidToQuotation(
      String userToken, var loginFormData) async {
    initConnectivity();
    var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse;

    apiResponse = await apiHitter.getPostApiResponse(
        ApiEndpoint.sendQuotationUrl,
        headers: auth,
        data: loginFormData);

    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<dynamic> addDeliveryMan(
      // String userToken,
      var loginFormData,
      bool isForm) async {
    initConnectivity();
    // var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse;
    if (isForm) {
      apiResponse = await apiHitter.getPostApiResponse(ApiEndpoint.userRegister,
          // headers: auth,
          isFormData: true,
          postFormData: loginFormData);
    } else {
      apiResponse = await apiHitter.getPostApiResponse(ApiEndpoint.userRegister,
          // headers: auth,
          data: loginFormData);
    }

    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }

  Future<dynamic> userUpdateProfile(
      String userToken, var loginFormData, bool isForm) async {
    initConnectivity();
    var auth = {"Authorization": 'Bearer $userToken'};
    debugPrint("vcarez the internet is ${_connectionStatus.name}");
    ApiResponse apiResponse;
    if (isForm) {
      apiResponse = await apiHitter.getPostApiResponse(
          ApiEndpoint.updateProfile,
          headers: auth,
          isFormData: true,
          postFormData: loginFormData);
    } else {
      apiResponse = await apiHitter.getPostApiResponse(
          ApiEndpoint.updateProfile,
          headers: auth,
          data: loginFormData);
    }

    {
      try {
        if (apiResponse.success) {
          debugPrint("vcarez the try first is${apiResponse.response!.data}");

          return ApiResponse(true,
              responseCode: apiResponse.responseCode,
              message: apiResponse.response!.data['message']);
        } else {
          return apiResponse;
        }
      } catch (error) {
        debugPrint("vcarez the error is $apiResponse");
        return ApiResponse(false,
            responseCode: 301, message: apiResponse.message);
        // return LoginModel(
        //     token: apiResponse.toString(), success: false);
      }
    }
  }
}
