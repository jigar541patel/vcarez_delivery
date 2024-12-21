class ApiEndpoint {
  // DEV API as on 14 june 2022
  static String baseUrl = "https://vcarez.com/adminmanagement/api/delivery";
  static String baseImageUrl = "https://home.dev.thebookus.com";
  static String socketUrl = "https://home.dev.thebookus.com/";
  static String baseUrlPwa = "https://home.dev.thebookus.com/api/pwa/";

  static String userLogin = "$baseUrl/login";
  static String forgotPassword = "$baseUrl/forget-password";
  static String updatePassword = "$baseUrl/update-password";
  static String userRegister = "$baseUrl/register";

  static String getUserprofile = "$baseUrl/view-profile";
  static String getNewOrder = "$baseUrl/my-order";
  static String getMedicineList = "$baseUrl/medicine";
  static String getBannerMDList = "$baseUrl/medicine-database-banners";
  static String getFeatureBrandList = "$baseUrl/top-brands";
  static String getBidCornerList = "$baseUrl/quotation-list";
  static String getMyOrderList = "$baseUrl/my-order";
  static String getDeliveryOrderList = "$baseUrl/completed-orders";
  static String getAssignOrderList = "$baseUrl/assigned-orders";
  static String acceptOrderList = "$baseUrl/my-order";
  static String rejectOrderList = "$baseUrl/reject-order";
  static String getMedicineSearchList = "$baseUrl/search-med";
  static String getMedicineDetail = "$baseUrl/medicine-detail/";
  static String getQuotationDetail = "$baseUrl/quotation-detail/";

  static String updateProfile = "$baseUrl/update-profile";
  static String getHealthCondition = "$baseUrl/health-conditions";
  static String addDeliveryBoy = "$baseUrl/add-delivery-boy";
  static String sendQuotationUrl = "$baseUrl/send-quotation";
  static String getMyQuotationUrl = "$baseUrl/get-my-quotations";

}
