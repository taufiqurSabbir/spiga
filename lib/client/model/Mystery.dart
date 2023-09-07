class Mystery {
  int? id;
  String? mysteryName;
  String? createdAt;
  String? updatedAt;

  Mystery({this.id, this.mysteryName, this.createdAt, this.updatedAt});

  Mystery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mysteryName = json['mystery_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mystery_name'] = this.mysteryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
