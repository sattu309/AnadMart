class FeedbackListModel {
  bool? status;
  String? message;
  Data? data;

  FeedbackListModel({this.status, this.message, this.data});

  FeedbackListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Feedback>? feedback;
  dynamic avgRating;
  dynamic avgRatingCount;

  Data({this.feedback, this.avgRating, this.avgRatingCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['feedback'] != null) {
      feedback = <Feedback>[];
      json['feedback'].forEach((v) {
        feedback!.add(new Feedback.fromJson(v));
      });
    }
    avgRating = json['avg_rating'];
    avgRatingCount = json['avg_rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedback != null) {
      data['feedback'] = this.feedback!.map((v) => v.toJson()).toList();
    }
    data['avg_rating'] = this.avgRating;
    data['avg_rating_count'] = this.avgRatingCount;
    return data;
  }
}

class Feedback {
  dynamic id;
  dynamic userName;
  dynamic image;
  dynamic rating;
  dynamic review;
  dynamic createdAt;

  Feedback(
      {this.id,
        this.userName,
        this.image,
        this.rating,
        this.review,
        this.createdAt});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    image = json['image'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    return data;
  }
}
