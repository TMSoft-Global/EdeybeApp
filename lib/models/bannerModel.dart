class BannerModel {
  Successs success;

  BannerModel({this.success});

  BannerModel.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? new Successs.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (success != null) {
      data['success'] = success.toJson();
    }
    return data;
  }
}

class Successs {
  String sId;
  String type;
  List<FirstSlider> firstSlider;
  List<FirstSlider> secondSlider;
  RightColumn rightColumn;

  Successs(
      {this.sId,
      this.type,
      this.firstSlider,
      this.secondSlider,
      this.rightColumn});

  Successs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    if (json['firstSlider'] != null) {
      firstSlider = <FirstSlider>[];
      json['firstSlider'].forEach((v) {
        firstSlider.add(new FirstSlider.fromJson(v));
      });
    }
    if (json['secondSlider'] != null) {
      secondSlider = <FirstSlider>[];
      json['secondSlider'].forEach((v) {
        secondSlider.add(new FirstSlider.fromJson(v));
      });
    }
    rightColumn = json['rightColumn'] != null
        ? new RightColumn.fromJson(json['rightColumn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['type'] = type;
    if (firstSlider != null) {
      data['firstSlider'] = firstSlider.map((v) => v.toJson()).toList();
    }
    if (secondSlider != null) {
      data['secondSlider'] = secondSlider.map((v) => v.toJson()).toList();
    }
    if (rightColumn != null) {
      data['rightColumn'] = rightColumn.toJson();
    }
    return data;
  }
}

class FirstSlider {
  String imageUrl;
  String productName;
  String productId;
  String type;
  String key;
  double aspect;
  Resolution resolution;

  FirstSlider(
      {this.imageUrl,
      this.productName,
      this.productId,
      this.type,
      this.key,
      this.aspect,
      this.resolution});

  FirstSlider.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    productName = json['productName'];
    productId = json['productId'];
    type = json['type'];
    key = json['key'];
    aspect = json['aspect'];
    resolution = json['resolution'] != null
        ? new Resolution.fromJson(json['resolution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = imageUrl;
    data['productName'] = productName;
    data['productId'] = productId;
    data['type'] = type;
    data['key'] = key;
    data['aspect'] = aspect;
    if (resolution != null) {
      data['resolution'] = resolution.toJson();
    }
    return data;
  }
}

class Resolution {
  int width;
  int height;

  Resolution({this.width, this.height});

  Resolution.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class RightColumn {
  TopLeftCorner topLeftCorner;
  TopLeftCorner topRightCorner;
  FirstSlider middle;
  TopLeftCorner bottomLeftCorner;
  TopLeftCorner bottomRightCorner;

  RightColumn(
      {this.topLeftCorner,
      this.topRightCorner,
      this.middle,
      this.bottomLeftCorner,
      this.bottomRightCorner});

  RightColumn.fromJson(Map<String, dynamic> json) {
    topLeftCorner = json['topLeftCorner'] != null
        ? new TopLeftCorner.fromJson(json['topLeftCorner'])
        : null;
    topRightCorner = json['topRightCorner'] != null
        ? new TopLeftCorner.fromJson(json['topRightCorner'])
        : null;
    middle = json['middle'] != null
        ? new FirstSlider.fromJson(json['middle'])
        : null;
    bottomLeftCorner = json['bottomLeftCorner'] != null
        ? new TopLeftCorner.fromJson(json['bottomLeftCorner'])
        : null;
    bottomRightCorner = json['bottomRightCorner'] != null
        ? new TopLeftCorner.fromJson(json['bottomRightCorner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (topLeftCorner != null) {
      data['topLeftCorner'] = topLeftCorner.toJson();
    }
    if (topRightCorner != null) {
      data['topRightCorner'] = topRightCorner.toJson();
    }
    if (middle != null) {
      data['middle'] = middle.toJson();
    }
    if (bottomLeftCorner != null) {
      data['bottomLeftCorner'] = bottomLeftCorner.toJson();
    }
    if (bottomRightCorner != null) {
      data['bottomRightCorner'] = bottomRightCorner.toJson();
    }
    return data;
  }
}

class TopLeftCorner {
  String imageUrl;
  String productName;
  String productId;
  String type;
  String key;
  int aspect;
  Resolution resolution;

  TopLeftCorner(
      {this.imageUrl,
      this.productName,
      this.productId,
      this.type,
      this.key,
      this.aspect,
      this.resolution});

  TopLeftCorner.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    productName = json['productName'];
    productId = json['productId'];
    type = json['type'];
    key = json['key'];
    aspect = json['aspect'];
    resolution = json['resolution'] != null
        ? new Resolution.fromJson(json['resolution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = imageUrl;
    data['productName'] = productName;
    data['productId'] = productId;
    data['type'] = type;
    data['key'] = key;
    data['aspect'] = aspect;
    if (resolution != null) {
      data['resolution'] = resolution.toJson();
    }
    return data;
  }
}
