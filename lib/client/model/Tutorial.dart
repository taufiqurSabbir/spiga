class Tutoral {
  int? id;
  String? tutorialTitle;
  String? tutorialSubTitle;
  String? image;
  String? createdAt;
  String? updatedAt;

  Tutoral(
      {this.id,
        this.tutorialTitle,
        this.tutorialSubTitle,
        this.image,
        this.createdAt,
        this.updatedAt});

  Tutoral.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorialTitle = json['tutorial_title'];
    tutorialSubTitle = json['tutorial_sub_title'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutorial_title'] = this.tutorialTitle;
    data['tutorial_sub_title'] = this.tutorialSubTitle;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
