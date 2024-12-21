class DeliveryHistoryModel {
  bool? success;
  String? message;
  List<Orders>? orders;

  DeliveryHistoryModel({this.success, this.message, this.orders});

  DeliveryHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  String? shop;
  String? orderNumber;
  String? shopAddress;
  String? customerName;
  String? customerPhone;
  String? deliveryAddress;
  int? completed;
  int? rejected;
  int? orderStatus;
  String? deliveredAt;

  Orders(
      {this.id,
        this.shop,
        this.orderNumber,
        this.shopAddress,
        this.customerName,
        this.customerPhone,
        this.deliveryAddress,
        this.completed,
        this.rejected,
        this.orderStatus,
        this.deliveredAt});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shop = json['shop'];
    orderNumber = json['order_number'];
    shopAddress = json['shop_address'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    deliveryAddress = json['delivery_address'];
    completed = json['completed'];
    rejected = json['rejected'];
    orderStatus = json['order_status'];
    deliveredAt = json['delivered_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop'] = this.shop;
    data['order_number'] = this.orderNumber;
    data['shop_address'] = this.shopAddress;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['delivery_address'] = this.deliveryAddress;
    data['completed'] = this.completed;
    data['rejected'] = this.rejected;
    data['order_status'] = this.orderStatus;
    data['delivered_at'] = this.deliveredAt;
    return data;
  }
}

