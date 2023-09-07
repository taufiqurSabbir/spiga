class UserInfo {
  String? userType;
  int? tutorialSteps;

  UserInfo({this.userType, this.tutorialSteps});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    tutorialSteps = json['tutorial_steps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['tutorial_steps'] = this.tutorialSteps;
    return data;
  }
}
