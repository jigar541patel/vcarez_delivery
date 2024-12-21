class AssignOrderModel {
  bool? success;
  String? message;
  List<AssignOrders>? orders;

  AssignOrderModel({this.success, this.message, this.orders});

  AssignOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <AssignOrders>[];
      json['orders'].forEach((v) {
        orders!.add(new AssignOrders.fromJson(v));
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

class AssignOrders {
  int? id;
  String? shop;
  String? orderNumber;
  String? shopAddress;
  String? customerName;
  String? customerPhone;
  String? deliveryAddress;
  var total;
  int? orderStatus;
  String? timeLeft;

  AssignOrders(
      {this.id,
        this.shop,
        this.orderNumber,
        this.shopAddress,
        this.customerName,
        this.customerPhone,
        this.deliveryAddress,
        this.total,
        this.orderStatus,
        this.timeLeft});

  AssignOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shop = json['shop'];
    orderNumber = json['order_number'];
    shopAddress = json['shop_address'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    deliveryAddress = json['delivery_address'];
    total = json['total'];
    orderStatus = json['order_status'];
    timeLeft = json['time_left'];
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
    data['total'] = this.total;
    data['order_status'] = this.orderStatus;
    data['time_left'] = this.timeLeft;
    return data;
  }
}
