class Privacy{
  String? policies;

  Privacy({this.policies});

  Privacy.fromJson(Map<String, dynamic> json) {
    policies = json['policies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['policies'] = this.policies;
    return data;
  }
}