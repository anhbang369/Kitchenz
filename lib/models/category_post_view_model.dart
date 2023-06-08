class CategoryPostViewModel {
  int? id;
  String? name;
  String? description;
  int? viewNumber;
  double? duration;
  String? status;
  String? imageUrl;
  bool? isVip;
  List<String>? likes = [];

  CategoryPostViewModel({
    this.id,
    this.name,
    this.description,
    this.viewNumber,
    this.duration,
    this.status,
    this.imageUrl,
    this.isVip,
    List<String>? likes,
  }) : likes = likes ?? [];

  CategoryPostViewModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> likesData =
        List<Map<String, dynamic>>.from(json['likes']);
    List<String> likeList = likesData
        .where((like) => like['status'] == 'ACTIVE')
        .map((like) => like['user']['id'].toString())
        .toList(growable: false);
    id = json['id'];
    name = json['name'];
    description = json['description'];
    viewNumber = json['viewNumber'];
    duration = double.parse(json['duration']);
    status = json['status'];
    imageUrl = json['imageUrl'];
    isVip = json['isVip'];
    likes = likeList;
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
