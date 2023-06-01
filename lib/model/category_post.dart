class ViewCategoryPost {
  int? id;
  String? name;
  String? description;
  int? viewNumber;
  double? duration;
  String? status;
  String? imageUrl;
  String? isVip;

  ViewCategoryPost({
    this.id,
    this.name,
    this.description,
    this.viewNumber,
    this.duration,
    this.status,
    this.imageUrl,
    this.isVip,
  });

  ViewCategoryPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    viewNumber = json['viewNumber'];
    duration = json['duration'];
    status = json['status'];
    imageUrl = json['imageUrl'];
    isVip = json['isVip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['viewNumber'] = viewNumber;
    data['duration'] = duration;
    data['status'] = status;
    data['imageUrl'] = imageUrl;
    data['isVip'] = isVip;
    return data;
  }
}
