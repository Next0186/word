class UserInfoModel {
  String token;
  String rfToken;
  String email;
  String avatar;
  List<Category> category;

  UserInfoModel(
      {this.token, this.rfToken, this.email, this.avatar, this.category});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    rfToken = json['rfToken'];
    email = json['email'];
    avatar = json['avatar'];
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['rfToken'] = this.rfToken;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String sId;
  String userId;
  String title;
  String subTitle;
  String createdAt;
  String updateAt;
  List<Words> words;

  Category(
      {this.sId,
      this.userId,
      this.title,
      this.subTitle,
      this.createdAt,
      this.updateAt,
      this.words});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    title = json['title'];
    subTitle = json['subTitle'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    if (json['words'] != null) {
      words = new List<Words>();
      json['words'].forEach((v) {
        words.add(new Words.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    if (this.words != null) {
      data['words'] = this.words.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Words {
  String sId;
  String wordId;
  String word;

  Words({this.sId, this.wordId, this.word});

  Words.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    wordId = json['wordId'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['wordId'] = this.wordId;
    data['word'] = this.word;
    return data;
  }
}
