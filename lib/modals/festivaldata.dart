class FestivalData {
  List<Festival>? festivalList;

  FestivalData({this.festivalList});

  FestivalData.fromJson(Map<String, dynamic> json) {
    if (json['festivalList'] != null) {
      festivalList = [];
      json['festivalList'].forEach((v) {
        festivalList?.add(Festival.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (festivalList != null) {
      data['festivalList'] = festivalList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Festival {
  String? id;
  String? name;
  List<String>? img;
  String? image;
  List<String>? description;

  Festival({this.id, this.name, this.img, this.image, this.description});

  Festival.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'].cast<String>();
    image = json['image'];
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
