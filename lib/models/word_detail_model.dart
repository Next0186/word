
class WordDetailModel {
  String id;
  String word;
  List<String> translate;
  Pronounce pronounce;
  String additional;
  String wordAudio;
  List<String> wordImage;
  // String origin;
  List<Origins> origins;
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
      this.origins,
      this.originEn,
      this.notFind,
      this.rank,
      this.example,
      this.id,
      this.comments});

  WordDetailModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    id = json['_id'];
    // translate = json['translate'];
    translate = json['translate'].cast<String>();
    pronounce = json['pronounce'] != null
        ? new Pronounce.fromJson(json['pronounce'])
        : null;
    additional = json['additional'];
    wordAudio = json['wordAudio'];
    wordImage = json['wordImage'].cast<String>();
    if (json['origins'] != null) {
      origins = new List<Origins>();
      json['origins'].forEach((v) {
        origins.add(new Origins.fromJson(v));
      });
    }
    // origin = json['origin'];
    
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
    // data['translate'] = this.translate;
    if (this.pronounce != null) {
      data['pronounce'] = this.pronounce.toJson();
    }
    data['additional'] = this.additional;
    data['wordAudio'] = this.wordAudio;
    data['wordImage'] = this.wordImage;
    // data['origin'] = this.origin;
    if (this.origins != null) {
      data['origins'] = this.origins.map((v) => v.toJson()).toList();
    }
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

class Origins {
  String sId;
  String title;
  String origin;

  Origins({this.sId, this.title, this.origin});

  Origins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    origin = json['origin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['origin'] = this.origin;
    return data;
  }
}
