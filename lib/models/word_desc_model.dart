class WordDescModel {
  List<DataList> dataList;
  MyDesc myDesc;
  int count;
  int page;

  WordDescModel({this.dataList, this.myDesc, this.count, this.page});

  WordDescModel.fromJson(Map<String, dynamic> json) {
    if (json['dataList'] != null) {
      dataList = new List<DataList>();
      json['dataList'].forEach((v) {
        dataList.add(new DataList.fromJson(v));
      });
    }
    myDesc =
        json['myDesc'] != null ? new MyDesc.fromJson(json['myDesc']) : null;
    count = json['count'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataList != null) {
      data['dataList'] = this.dataList.map((v) => v.toJson()).toList();
    }
    if (this.myDesc != null) {
      data['myDesc'] = this.myDesc.toJson();
    }
    data['count'] = this.count;
    data['page'] = this.page;
    return data;
  }
}

class DataList {
  String sId;
  String like;
  String desc;
  String wordId;
  String userId;
  String updateAt;
  String avatar;
  int commentCount;
  String userName;

  DataList(
      {this.sId,
      this.like,
      this.desc,
      this.wordId,
      this.userId,
      this.updateAt,
      this.avatar,
      this.commentCount,
      this.userName});

  DataList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    like = json['like'];
    desc = json['desc'];
    wordId = json['wordId'];
    userId = json['userId'];
    updateAt = json['updateAt'];
    avatar = json['avatar'];
    commentCount = json['commentCount'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['like'] = this.like;
    data['desc'] = this.desc;
    data['wordId'] = this.wordId;
    data['userId'] = this.userId;
    data['updateAt'] = this.updateAt;
    data['avatar'] = this.avatar;
    data['commentCount'] = this.commentCount;
    data['userName'] = this.userName;
    return data;
  }
}

class MyDesc {
  String like;
  int commentCount;
  String sId;
  String wordId;
  String userId;
  String desc;
  String createdAt;
  String updateAt;

  MyDesc(
      {this.like,
      this.commentCount,
      this.sId,
      this.wordId,
      this.userId,
      this.desc,
      this.createdAt,
      this.updateAt});

  MyDesc.fromJson(Map<String, dynamic> json) {
    like = json['like'];
    commentCount = json['commentCount'];
    sId = json['_id'];
    wordId = json['wordId'];
    userId = json['userId'];
    desc = json['desc'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['like'] = this.like;
    data['commentCount'] = this.commentCount;
    data['_id'] = this.sId;
    data['wordId'] = this.wordId;
    data['userId'] = this.userId;
    data['desc'] = this.desc;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
