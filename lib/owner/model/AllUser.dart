class AllUsers {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? phone;
  String? address;
  int? packageId;
  int? totalSms;
  int? sendMessage;
  int? remainingMessage;
  int? amount;
  String? status;
  String? fcmid;
  String? uid;
  int? tutorialSteps;
  int? orderNotification;
  int? outOfStockNotification;
  int? pushNotification;
  String? profilePhotoUrl;

  AllUsers(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.phone,
        this.address,
        this.packageId,
        this.totalSms,
        this.sendMessage,
        this.remainingMessage,
        this.amount,
        this.status,
        this.fcmid,
        this.uid,
        this.tutorialSteps,
        this.orderNotification,
        this.outOfStockNotification,
        this.pushNotification,
        this.profilePhotoUrl});

  AllUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    phone = json['phone'];
    address = json['address'];
    packageId = json['package_id'];
    totalSms = json['total_sms'];
    sendMessage = json['send_message'];
    remainingMessage = json['remaining_message'];
    amount = json['amount'];
    status = json['status'];
    fcmid = json['fcmid'];
    uid = json['uid'];
    tutorialSteps = json['tutorial_steps'];
    orderNotification = json['order_notification'];
    outOfStockNotification = json['out_of_stock_notification'];
    pushNotification = json['push_notification'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['package_id'] = this.packageId;
    data['total_sms'] = this.totalSms;
    data['send_message'] = this.sendMessage;
    data['remaining_message'] = this.remainingMessage;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['fcmid'] = this.fcmid;
    data['uid'] = this.uid;
    data['tutorial_steps'] = this.tutorialSteps;
    data['order_notification'] = this.orderNotification;
    data['out_of_stock_notification'] = this.outOfStockNotification;
    data['push_notification'] = this.pushNotification;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
