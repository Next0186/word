
class WordDetailModel {
  String id;
  String word;
  String translate;
  Pronounce pronounce;
  List<String> additional;
  String wordAudio;
  List<String> wordImage;
  String origin;
  String originEn;
  bool notFind;
  String rank;
  Example example;
  List<Comments> comments;

  WordDetailModel(
      {this.word,
      this.translate,
      this.pronounce,
      this.additional,
      this.wordAudio,
      this.wordImage,
      this.origin,
      this.originEn,
      this.notFind,
      this.rank,
      this.example,
      this.id,
      this.comments});

  WordDetailModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    id = json['_id'];
    translate = json['translate'];
    pronounce = json['pronounce'] != null
        ? new Pronounce.fromJson(json['pronounce'])
        : null;
    additional = json['additional'].cast<String>();
    wordAudio = json['wordAudio'];
    wordImage = json['wordImage'].cast<String>();
    origin = json['origin'];
    originEn = json['originEn'];
    notFind = json['notFind'];
    rank = json['rank'];
    example =
        json['example'] != null ? new Example.fromJson(json['example']) : null;
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['_id'] = this.id;
    data['translate'] = this.translate;
    if (this.pronounce != null) {
      data['pronounce'] = this.pronounce.toJson();
    }
    data['additional'] = this.additional;
    data['wordAudio'] = this.wordAudio;
    data['wordImage'] = this.wordImage;
    data['origin'] = this.origin;
    data['originEn'] = this.originEn;
    data['notFind'] = this.notFind;
    data['rank'] = this.rank;
    if (this.example != null) {
      data['example'] = this.example.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pronounce {
  String en;
  String us;

  Pronounce({this.en, this.us});

  Pronounce.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    us = json['us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['us'] = this.us;
    return data;
  }
}

class Example {
  String en;
  String zh;

  Example({this.en, this.zh});

  Example.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    zh = json['zh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['zh'] = this.zh;
    return data;
  }
}

class Comments {
  String userName;
  String avatar;
  String comment;
  String createTime;

  Comments({this.userName, this.avatar, this.comment, this.createTime});

  Comments.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    avatar = json['avatar'];
    comment = json['comment'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['avatar'] = this.avatar;
    data['comment'] = this.comment;
    data['createTime'] = this.createTime;
    return data;
  }
}
