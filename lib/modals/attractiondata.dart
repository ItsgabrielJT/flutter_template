class AttractionData {
  List<Attraction>? attractionList;
  List<Attraction>? restaurantList;

  AttractionData({this.attractionList, this.restaurantList});

  AttractionData.fromJson(Map<String, dynamic> json) {
    if (json['attractionList'] != null) {
      attractionList = [];
      json['attractionList'].forEach((v) {
        attractionList?.add(Attraction.fromJson(v));
      });
    }
    if (json['restaurantList'] != null) {
      restaurantList = [];
      json['restaurantList'].forEach((v) {
        restaurantList?.add(Attraction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attractionList != null) {
      data['attractionList'] =
          attractionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyData {
  List<Attraction>? attractionList;

  NearbyData({this.attractionList});

  NearbyData.fromJson(Map<String, dynamic> json) {
    if (json['attractionByProvince'] != null) {
      attractionList = [];
      json['attractionByProvince'].forEach((v) {
        attractionList?.add(Attraction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attractionList != null) {
      data['attractionByProvince'] =
          attractionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attraction {
  String? id, name, image, district;
  int? province;
  List<String>? description, img;
  double? latitude;
  double? longitude;

  Attraction(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.latitude,
      this.longitude,
      this.img,
      this.district,
      this.province});

  Attraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'].cast<String>();
    latitude = json['latitude'];
    longitude = json['longitude'];
    img = json['img'].cast<String>();
    district = json['district'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['img'] = img;
    data['district'] = district;
    data['province'] = province;
    return data;
  }
}
