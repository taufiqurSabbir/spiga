class UserOrder {
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
  String? foodName;
  String? foodImage;
  String? pickupDateFrom;
  String? foodStock;
  String? customerPickupTimeFrom;
  String? customerPickupTimeTo;
  String? refundId;


  UserOrder(
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
        this.foodName,
        this.foodImage,
        this.pickupDateFrom,
        this.foodStock,
        this.customerPickupTimeFrom,
        this.customerPickupTimeTo,
        this.refundId
      });

  UserOrder.fromJson(Map<String, dynamic> json) {
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
    foodName = json['food_name'];
    foodImage = json['food_image'];
    pickupDateFrom = json['pickup_date_from'];
    foodStock = json['food_stock'];
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
    data['food_name'] = this.foodName;
    data['food_image'] = this.foodImage;
    data['pickup_date_from'] = this.pickupDateFrom;
    data['food_stock'] = this.foodStock;
    data['customer_pickup_time_from'] = this.customerPickupTimeFrom;
    data['customer_pickup_time_to'] = this.customerPickupTimeTo;
    data['refund_id'] = this.refundId;

    return data;
  }
}