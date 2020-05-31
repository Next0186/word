class WordModel {
  List<String> translate;
  List<StarList> starList;
  List<String> wordImage;
  String sId;
  String word;
  Pronounce pronounce;
  String additional;
  String wordAudio;
  List<Origins> origins;
  String originEn;
  String rank;
  Example example;
  String createdAt;
  List<WordDesc> wordDesc;

  WordModel(
      {this.translate,
      this.starList,
      this.wordImage,
      this.sId,
      this.word,
      this.pronounce,
      this.additional,
      this.wordAudio,
      this.origins,
      this.originEn,
      this.rank,
      this.example,
      this.createdAt,
      this.wordDesc});

  WordModel.fromJson(Map<String, dynamic> json) {
    translate = json['translate'].cast<String>();
    if (json['starList'] != null) {
      starList = new List<StarList>();
      json['starList'].forEach((v) {
        starList.add(new StarList.fromJson(v));
      });
    }
    wordImage = json['wordImage'].cast<String>();
    sId = json['_id'];
    word = json['word'];
    pronounce = json['pronounce'] != null
        ? new Pronounce.fromJson(json['pronounce'])
        : null;
    additional = json['additional'];
    wordAudio = json['wordAudio'];
    if (json['origins'] != null) {
      origins = new List<Origins>();
      json['origins'].forEach((v) {
        origins.add(new Origins.fromJson(v));
      });
    }
    originEn = json['originEn'];
    rank = json['rank'];
    example =
        json['example'] != null ? new Example.fromJson(json['example']) : null;
    createdAt = json['createdAt'];
    if (json['wordDesc'] != null) {
      wordDesc = new List<WordDesc>();
      json['wordDesc'].forEach((v) {
        wordDesc.add(new WordDesc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['translate'] = this.translate;
    if (this.starList != null) {
      data['starList'] = this.starList.map((v) => v.toJson()).toList();
    }
    data['wordImage'] = this.wordImage;
    data['_id'] = this.sId;
    data['word'] = this.word;
    if (this.pronounce != null) {
      data['pronounce'] = this.pronounce.toJson();
    }
    data['additional'] = this.additional;
    data['wordAudio'] = this.wordAudio;
    if (this.origins != null) {
      data['origins'] = this.origins.map((v) => v.toJson()).toList();
    }
    data['originEn'] = this.originEn;
    data['rank'] = this.rank;
    if (this.example != null) {
      data['example'] = this.example.toJson();
    }
    data['createdAt'] = this.createdAt;
    if (this.wordDesc != null) {
      data['wordDesc'] = this.wordDesc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StarList {
  String sId;
  String title;
  String subTitle;

  StarList({this.sId, this.title, this.subTitle});

  StarList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subTitle = json['subTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
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

class WordDesc {
  String sId;
  String desc;
  String updateAt;

  WordDesc({this.sId, this.desc, this.updateAt});

  WordDesc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    desc = json['desc'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['desc'] = this.desc;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
