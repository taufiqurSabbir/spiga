class UserAuth {
  String? name;
  String? last_name;
  String? email;
  String? password;
  String? token;
  String? status;
  String? user;

  UserAuth({this.name,this.last_name, this.email, this.password, this.token, this.status, this.user});

  UserAuth.resp(Map<String?, dynamic> json) {
    token = json['token'];
    status = json['status'];
    user = json['user'];
  }

  Map<String, dynamic> body() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name ?? '';
    data['last_name'] = this.last_name ?? '';
    data['email'] = this.email ?? '';
    data['password'] = this.password ?? '';
    return data;
  }
}