class RestaurantData {
  List<Restaurant>? restaurantList;
  List<Restaurant>? cafeList;
  List<Restaurant>? pubList;
  RestaurantData({this.restaurantList, this.cafeList, this.pubList});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    if (json['restaurantList'] != null) {
      restaurantList = [];
      json['restaurantList'].forEach((v) {
        restaurantList?.add(Restaurant.fromJson(v));
      });
    }
    if (json['cafeList'] != null) {
      cafeList = [];
      json['cafeList'].forEach((v) {
        cafeList?.add(Restaurant.fromJson(v));
      });
    }
    if (json['pubList'] != null) {
      pubList = [];
      json['pubList'].forEach((v) {
        pubList?.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (restaurantList != null) {
      data['restaurantList'] =
          restaurantList?.map((v) => v.toJson()).toList();
    }
    if (cafeList != null) {
      data['cafeList'] = cafeList?.map((v) => v.toJson()).toList();
    }
    if (pubList != null) {
      data['pubList'] = pubList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyData {
  List<Restaurant>? restaurantList;

  NearbyData({this.restaurantList});

  NearbyData.fromJson(Map<String, dynamic> json) {
    if (json['RestaurantByProvince'] != null) {
      restaurantList = [];
      json['RestaurantByProvince'].forEach((v) {
        restaurantList?.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (restaurantList != null) {
      data['restaurantByProvince'] =
          restaurantList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String? id, name, image, district, description;
  int? province;
  List<String>? img;
  double? latitude;
  double? longitude;

  Restaurant(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.latitude,
      this.longitude,
      this.img,
      this.district,
      this.province});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
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
