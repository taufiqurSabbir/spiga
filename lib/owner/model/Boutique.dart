class Boutique {
  int? id;
  String? boutiqueName;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? openedAt;
  String? closedAt;

  Boutique(
      {this.id,
        this.boutiqueName,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.openedAt,
        this.closedAt});

  Boutique.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boutiqueName = json['boutique_name'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    openedAt = json['opened_at'];
    closedAt = json['closed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['boutique_name'] = this.boutiqueName;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['opened_at'] = this.openedAt;
    data['closed_at'] = this.closedAt;
    return data;
  }
}
