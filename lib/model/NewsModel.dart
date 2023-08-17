class NewsModel {
  String? newsId;
  String? newsTitle;
  String? newsDetail;
  String? newsDate;
  String? newsImg;
  String? newsType;
  String? totalView;
  String? totalComment;
  String? totalLike;
  String? status;
  String? uid;
  String? username;
  String? password;
  String? email;
  String? userType;

  NewsModel(
      {this.newsId,
      this.newsTitle,
      this.newsDetail,
      this.newsDate,
      this.newsImg,
      this.newsType,
      this.totalView,
      this.totalComment,
      this.totalLike,
      this.status,
      this.uid,
      this.username,
      this.password,
      this.email,
      this.userType});

  NewsModel.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    newsDetail = json['news_detail'];
    newsDate = json['news_date'];
    newsImg = json['news_img'];
    newsType = json['news_type'];
    totalView = json['total_view'];
    totalComment = json['total_comment'];
    totalLike = json['total_like'];
    status = json['status'];
    uid = json['uid'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['news_title'] = this.newsTitle;
    data['news_detail'] = this.newsDetail;
    data['news_date'] = this.newsDate;
    data['news_img'] = this.newsImg;
    data['news_type'] = this.newsType;
    data['total_view'] = this.totalView;
    data['total_comment'] = this.totalComment;
    data['total_like'] = this.totalLike;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['user_type'] = this.userType;
    return data;
  }
}
