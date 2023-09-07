class Order {
  Data? data;
  String? status;

  Order({this.data, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? foodId;
  int? quantity;
  String? customerName;
  int? userId;
  int? paymentStatus;
  String? pickupTime;
  String? orderDate;
  String? transactionId;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? customerPickUpTimeFrom;
  String? customerPickUpTimeTo;

  Data(
      {this.foodId,
        this.quantity,
        this.customerName,
        this.userId,
        this.paymentStatus,
        this.pickupTime,
        this.orderDate,
        this.transactionId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.customerPickUpTimeFrom,
        this.customerPickUpTimeTo
      });

  Data.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    quantity = json['quantity'];
    customerName = json['customer_name'];
    userId = json['user_id'];
    paymentStatus = json['payment_status'];
    pickupTime = json['pickup_time'];
    orderDate = json['order_date'];
    transactionId = json['transaction_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    customerPickUpTimeFrom = json['customer_pickup_time_from'];
    customerPickUpTimeTo = json['customer_pickup_time_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;
    data['quantity'] = this.quantity;
    data['customer_name'] = this.customerName;
    data['user_id'] = this.userId;
    data['payment_status'] = this.paymentStatus;
    data['pickup_time'] = this.pickupTime;
    data['order_date'] = this.orderDate;
    data['transaction_id'] = this.transactionId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['customer_pickup_time_from'] = this.customerPickUpTimeFrom;
    data['customer_pickup_time_to'] = this.customerPickUpTimeTo;
    return data;
  }
}
