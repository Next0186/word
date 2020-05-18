class WordListModel {
  int page;
  int count;
  List<DataList> dataList;

  WordListModel({this.page, this.count, this.dataList});

  WordListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    count = json['count'];
    if (json['dataList'] != null) {
      dataList = new List<DataList>();
      json['dataList'].forEach((v) {
        dataList.add(new DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['count'] = this.count;
    if (this.dataList != null) {
      data['dataList'] = this.dataList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  List<Words> words;
  String translate;
  String avatar;
  String sentence;

  DataList({this.words, this.translate, this.avatar, this.sentence});

  DataList.fromJson(Map<String, dynamic> json) {
    if (json['words'] != null) {
      words = new List<Words>();
      json['words'].forEach((v) {
        words.add(new Words.fromJson(v));
      });
    }
    translate = json['translate'];
    avatar = json['avatar'];
    sentence = json['sentence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.words != null) {
      data['words'] = this.words.map((v) => v.toJson()).toList();
    }
    data['translate'] = this.translate;
    data['avatar'] = this.avatar;
    data['sentence'] = this.sentence;
    return data;
  }
}

class Words {
  int id;
  List<String> translate;
  List<String> similar;
  Sign sign;
  int frequency;
  int difficultRank;
  String word;
  bool disable;
  String etymology;
  String origin;
  String avatar;

  Words(
      {this.id,
      this.translate,
      this.similar,
      this.sign,
      this.frequency,
      this.difficultRank,
      this.word,
      this.disable,
      this.etymology,
      this.origin,
      this.avatar});

  Words.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    translate = json['translate'].cast<String>();
    similar = json['similar'].cast<String>();
    sign = json['sign'] != null ? new Sign.fromJson(json['sign']) : null;
    frequency = json['frequency'];
    difficultRank = json['difficultRank'];
    word = json['word'];
    disable = json['disable'];
    etymology = json['etymology'];
    origin = json['origin'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['translate'] = this.translate;
    data['similar'] = this.similar;
    if (this.sign != null) {
      data['sign'] = this.sign.toJson();
    }
    data['frequency'] = this.frequency;
    data['difficultRank'] = this.difficultRank;
    data['word'] = this.word;
    data['disable'] = this.disable;
    data['etymology'] = this.etymology;
    data['origin'] = this.origin;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Sign {
  String en;
  String us;

  Sign({this.en, this.us});

  Sign.fromJson(Map<String, dynamic> json) {
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
