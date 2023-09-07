class Order_History {
  List<Orders>? orders;
  String? status;

  Order_History({this.orders, this.status});

  Order_History.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Orders {
  int? id;
  int? foodId;
  String? customerName;
  int? paymentStatus;
  String? pickupTime;
  String? orderDate;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  int? userId;
  String? transactionId;
  int? orderStatus;
  int? order;
  String? netPrice;
  String? totalPrice;
  String? customerPickupTimeFrom;
  String? customerPickupTimeTo;
  String? refundId;

  Orders(
      {this.id,
        this.foodId,
        this.customerName,
        this.paymentStatus,
        this.pickupTime,
        this.orderDate,
        this.createdAt,
        this.updatedAt,
        this.quantity,
        this.userId,
        this.transactionId,
        this.orderStatus,
        this.order,
        this.netPrice,
        this.totalPrice,
        this.customerPickupTimeFrom,
        this.customerPickupTimeTo,
        this.refundId
      });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    customerName = json['customer_name'];
    paymentStatus = json['payment_status'];
    pickupTime = json['pickup_time'];
    orderDate = json['order_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity = json['quantity'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    orderStatus = json['order_status'];
    order = json['order'];
    netPrice = json['net_price'];
    totalPrice = json['total_price'];
    customerPickupTimeFrom = json['customer_pickup_time_from'];
    customerPickupTimeTo = json['customer_pickup_time_to'];
    refundId = json['refund_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_id'] = this.foodId;
    data['customer_name'] = this.customerName;
    data['payment_status'] = this.paymentStatus;
    data['pickup_time'] = this.pickupTime;
    data['order_date'] = this.orderDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['quantity'] = this.quantity;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['order_status'] = this.orderStatus;
    data['order'] = this.order;
    data['net_price'] = this.netPrice;
    data['total_price'] = this.totalPrice;
    data['customer_pickup_time_from'] = this.customerPickupTimeFrom;
    data['customer_pickup_time_to'] = this.customerPickupTimeTo;
    data['refund_id'] = this.refundId;
    return data;
  }
}



class OrdersWithOrderDateInDateTimeObj {
  int? id;
  int? foodId;
  String? customerName;
  int? paymentStatus;
  String? pickupTime;
  //Here  order date  is  in date time  object
  DateTime? orderDate;

  String? createdAt;
  String? updatedAt;
  int? quantity;
  int? userId;
  String? transactionId;
  int? orderStatus;
  int? order;
  String? netPrice;
  String? totalPrice;
  String? customerPickupTimeFrom;
  String? customerPickupTimeTo;
  String? refundId;

  OrdersWithOrderDateInDateTimeObj(int? id,  int? foodId,  String? customerName,  int? paymentStatus,  String? pickupTime,  DateTime? orderDate,  String? createdAt,  String? updatedAt,  int? quantity,  int? userId,  String? transactionId,  int? orderStatus, int? order,  String? netPrice,  String? totalPrice,   String? customerPickupTimeFrom, String? customerPickupTimeTo, String? refundId){
    this.id = id;
    this.foodId = foodId;
    this.customerName = customerName;
    this.paymentStatus = paymentStatus;
    this.pickupTime = pickupTime;
    this.orderDate = orderDate;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.quantity = quantity;
    this.userId = userId;
    this.transactionId = transactionId;
    this.orderStatus = orderStatus;
    this.order = order;
    this.netPrice = netPrice;
    this.totalPrice = totalPrice;
    this.customerPickupTimeFrom = customerPickupTimeFrom;
    this.customerPickupTimeTo = customerPickupTimeTo;
    this.refundId = refundId;
  }


  OrdersWithOrderDateInDateTimeObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    customerName = json['customer_name'];
    paymentStatus = json['payment_status'];
    pickupTime = json['pickup_time'];
    orderDate = json['order_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity = json['quantity'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    orderStatus = json['order_status'];
    order = json['order'];
    netPrice = json['net_price'];
    totalPrice = json['total_price'];
    customerPickupTimeFrom = json['customer_pickup_time_from'];
    customerPickupTimeTo = json['customer_pickup_time_to'];
    refundId = json['refund_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_id'] = this.foodId;
    data['customer_name'] = this.customerName;
    data['payment_status'] = this.paymentStatus;
    data['pickup_time'] = this.pickupTime;
    data['order_date'] = this.orderDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['quantity'] = this.quantity;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['order_status'] = this.orderStatus;
    data['order'] = this.order;
    data['net_price'] = this.netPrice;
    data['total_price'] = this.totalPrice;
    data['customer_pickup_time_from'] = this.customerPickupTimeFrom;
    data['customer_pickup_time_to'] = this.customerPickupTimeTo;
    data['refund_id'] = this.refundId;
    return data;
  }
}
