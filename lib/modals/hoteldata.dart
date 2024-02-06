class HotelListData {
  List<Hotel>? hotelList;

  HotelListData({this.hotelList});

  HotelListData.fromJson(Map<String, dynamic> json) {
    if (json['hotelList'] != null) {
      hotelList = [];
      json['hotelList'].forEach((v) {
        hotelList?.add(Hotel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hotelList != null) {
      data['hotelList'] = hotelList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hotel {
  String? id;
  String? name;
  List<String>? img;
  String? place;
  String? district;
  double? latitude;
  double? longitude;
  String? cost;
  int? province;
  String? description;
  String? star;
  String? url;
  List<String>? amenities;

  Hotel(
      {this.id,
      this.name,
      this.img,
      this.place,
      this.district,
      this.latitude,
      this.longitude,
      this.cost,
      this.province,
      this.description,
      this.star,
      this.url,
      this.amenities});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'].cast<String>();
    place = json['place'];
    district = json['district'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cost = json['cost'];
    province = json['province'];
    description = json['description'];
    star = json['star'];
    url = json['url'];
    amenities = json['amenities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['place'] = place;
    data['district'] = district;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['cost'] = cost;
    data['province'] = province;
    data['description'] = description;
    data['star'] = star;
    data['url'] = url;
    data['amenities'] = amenities;
    return data;
  }
}
