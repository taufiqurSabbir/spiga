class Profile {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? orderNotification;
  int? outOfStockNotification;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.orderNotification,
        this.outOfStockNotification,
        this.createdAt,
        this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    orderNotification = json['order_notification'];
    outOfStockNotification = json['out_of_stock_notification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['order_notification'] = this.orderNotification;
    data['out_of_stock_notification'] = this.outOfStockNotification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
