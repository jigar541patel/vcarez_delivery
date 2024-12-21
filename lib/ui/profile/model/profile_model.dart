class ProfileModel {
  bool? success;
  String? message;
  Driver? driver;

  ProfileModel({this.success, this.message, this.driver});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    return data;
  }
}

class Driver {
  int? id;
  String? name;
  String? email;
  String? phone;
  var deviceToken;
  var emailVerifiedAt;
  int? active;
  var lattitude;
  var longitude;
  String? createdAt;
  String? updatedAt;
  var driverDetail;

  Driver(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.deviceToken,
        this.emailVerifiedAt,
        this.active,
        this.lattitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.driverDetail});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    deviceToken = json['device_token'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driverDetail = json['driver_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['device_token'] = this.deviceToken;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['driver_detail'] = this.driverDetail;
    return data;
  }
}
