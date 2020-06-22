import 'package:word/models/word_detail_model.dart';

class SentenceModel {
  String sentence;
  List<WordDetailModel> words;
  Star star;

  SentenceModel({this.sentence, this.words, this.star});

  SentenceModel.fromJson(Map<String, dynamic> json) {
    sentence = json['sentence'];
    if (json['words'] != null) {
      words = new List<WordDetailModel>();
      json['words'].forEach((v) {
        words.add(new WordDetailModel.fromJson(v));
      });
    }
    star = json['star'] != null ? new Star.fromJson(json['star']) : null;
    // star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sentence'] = this.sentence;
    if (this.words != null) {
      data['words'] = this.words.map((v) => v.toJson()).toList();
    }
    // data['star'] = this.star;
    if (this.star != null) {
      data['star'] = this.star.toJson();
    }
    return data;
  }
}

class Star {
  String sId;
  String userId;
  String sentence;
  List<Words> words;
  String groupId;
  String createdAt;

  Star(
      {this.sId,
      this.userId,
      this.sentence,
      this.words,
      this.groupId,
      this.createdAt});

  Star.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    sentence = json['sentence'];
    if (json['words'] != null) {
      words = new List<Words>();
      json['words'].forEach((v) {
        words.add(new Words.fromJson(v));
      });
    }
    groupId = json['groupId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['sentence'] = this.sentence;
    if (this.words != null) {
      data['words'] = this.words.map((v) => v.toJson()).toList();
    }
    data['groupId'] = this.groupId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Words {
  String sId;
  String word;

  Words({this.sId, this.word});

  Words.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['word'] = this.word;
    return data;
  }
}

