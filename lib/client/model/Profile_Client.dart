class ProfileClient{
  int? id;
  String? name;
  String? last_name;
  String? email;
  String? phone;
  int? pushNotification;

  ProfileClient(
      {this.id, this.name,this.last_name, this.email, this.phone, this.pushNotification});

  ProfileClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    last_name = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    pushNotification = json['push_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['last_name'] = this.last_name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['push_notification'] = this.pushNotification;
    return data;
  }
}

