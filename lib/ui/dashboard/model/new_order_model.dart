class NewOrderModel {
  bool? success;
  String? message;
  List<NewOrders>? orders;

  NewOrderModel({this.success, this.message, this.orders});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <NewOrders>[];
      json['orders'].forEach((v) {
        orders!.add(new NewOrders.fromJson(v));
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

class NewOrders {
  int? id;
  String? orderNumber;
  String? shop;
  String? shopAddress;
  String? customerName;
  String? customerPhone;
  String? deliveryAddress;

  NewOrders(
      {this.id,
        this.orderNumber,
        this.shop,
        this.shopAddress,
        this.customerName,
        this.customerPhone,
        this.deliveryAddress});

  NewOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    shop = json['shop'];
    shopAddress = json['shop_address'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    deliveryAddress = json['delivery_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['shop'] = this.shop;
    data['shop_address'] = this.shopAddress;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['delivery_address'] = this.deliveryAddress;
    return data;
  }
}
