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
    data['_id'] = this.sId;
    data['type'] = this.type;
    if (this.firstSlider != null) {
      data['firstSlider'] = this.firstSlider.map((v) => v.toJson()).toList();
    }
    if (this.secondSlider != null) {
      data['secondSlider'] = this.secondSlider.map((v) => v.toJson()).toList();
    }
    if (this.rightColumn != null) {
      data['rightColumn'] = this.rightColumn.toJson();
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
    data['imageUrl'] = this.imageUrl;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['type'] = this.type;
    data['key'] = this.key;
    data['aspect'] = this.aspect;
    if (this.resolution != null) {
      data['resolution'] = this.resolution.toJson();
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
    data['width'] = this.width;
    data['height'] = this.height;
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
    if (this.topLeftCorner != null) {
      data['topLeftCorner'] = this.topLeftCorner.toJson();
    }
    if (this.topRightCorner != null) {
      data['topRightCorner'] = this.topRightCorner.toJson();
    }
    if (this.middle != null) {
      data['middle'] = this.middle.toJson();
    }
    if (this.bottomLeftCorner != null) {
      data['bottomLeftCorner'] = this.bottomLeftCorner.toJson();
    }
    if (this.bottomRightCorner != null) {
      data['bottomRightCorner'] = this.bottomRightCorner.toJson();
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
    data['imageUrl'] = this.imageUrl;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['type'] = this.type;
    data['key'] = this.key;
    data['aspect'] = this.aspect;
    if (this.resolution != null) {
      data['resolution'] = this.resolution.toJson();
    }
    return data;
  }
}
