import 'package:word/models/word_detail_model.dart';

class SentenceModel {
  String sentence;
  List<WordDetailModel> words;
  dynamic star;

  SentenceModel({this.sentence, this.words, this.star});

  SentenceModel.fromJson(Map<String, dynamic> json) {
    sentence = json['sentence'];
    if (json['words'] != null) {
      words = new List<WordDetailModel>();
      json['words'].forEach((v) {
        words.add(new WordDetailModel.fromJson(v));
      });
    }
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sentence'] = this.sentence;
    if (this.words != null) {
      data['words'] = this.words.map((v) => v.toJson()).toList();
    }
    data['star'] = this.star;
    return data;
  }
}
