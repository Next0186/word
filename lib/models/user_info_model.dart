class UserInfoModel {
  String token;
  String rfToken;
  String email;
  String avatar;

  UserInfoModel({this.token, this.rfToken, this.email, this.avatar});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    rfToken = json['rfToken'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['rfToken'] = this.rfToken;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}
