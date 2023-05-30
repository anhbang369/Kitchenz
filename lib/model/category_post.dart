class ViewCategoryPost {
  int? id;
  String? name;
  String? description;
  int? viewNumber;
  double? duration;
  String? status;
  String? imageUrl;
  String? isVip;

  ViewCategoryPost(
      {this.id,
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['viewNumber'] = this.viewNumber;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['imageUrl'] = this.imageUrl;
    data['isVip'] = this.isVip;
    return data;
  }
}
