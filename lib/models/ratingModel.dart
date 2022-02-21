class RatingCommentModel {
  var productRating;
  var totalRating;
  List<Ratings> ratings;
  BreakDownRatings breakDownRatings;
  var totalRatingWithoutComment;

  RatingCommentModel(
      {this.productRating,
      this.totalRating,
      this.ratings,
      this.breakDownRatings,
      this.totalRatingWithoutComment});

  RatingCommentModel.fromJson(Map<String, dynamic> json) {
    productRating = json['productRating'];
    totalRating = json['totalRating'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings.add(new Ratings.fromJson(v));
      });
    }else{
      Ratings();
    }
    breakDownRatings = json['breakDownRatings'] != null
        ? new BreakDownRatings.fromJson(json['breakDownRatings'])
        : BreakDownRatings();
    totalRatingWithoutComment = json['totalRatingWithoutComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productRating'] = productRating;
    data['totalRating'] = totalRating;
    if (ratings != null) {
      data['ratings'] = ratings.map((v) => v.toJson()).toList();
    }
    if (breakDownRatings != null) {
      data['breakDownRatings'] = breakDownRatings.toJson();
    }
    data['totalRatingWithoutComment'] = totalRatingWithoutComment;
    return data;
  }
}

class Ratings {
  String sId;
  dynamic rating;
  String comment;
  String user;
  String productId;
  String variantId;
  bool isVariant;
  String transactionId;
  bool flagged;

  Ratings(
      {this.sId,
      this.rating,
      this.comment,
      this.user,
      this.productId,
      this.variantId,
      this.isVariant,
      this.transactionId,
      this.flagged});

  Ratings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = json['rating'];
    comment = json['comment'];
    user = json['user'];
    productId = json['productId'];
    variantId = json['variantId'];
    isVariant = json['isVariant'];
    transactionId = json['transactionId'];
    flagged = json['flagged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['rating'] = rating;
    data['comment'] = comment;
    data['user'] = user;
    data['productId'] = productId;
    data['variantId'] = variantId;
    data['isVariant'] = isVariant;
    data['transactionId'] = transactionId;
    data['flagged'] = flagged;
    return data;
  }
}

class BreakDownRatings {
  String star1;
  String star2;
  String star3;
  String star4;
  String star5;

  BreakDownRatings(
      {this.star1, this.star2, this.star3, this.star4, this.star5});

  BreakDownRatings.fromJson(Map<String, dynamic> json) {
    star1 = json['star_1'];
    star2 = json['star_2'];
    star3 = json['star_3'];
    star4 = json['star_4'];
    star5 = json['star_5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['star_1'] = star1;
    data['star_2'] = star2;
    data['star_3'] = star3;
    data['star_4'] = star4;
    data['star_5'] = star5;
    return data;
  }
}
