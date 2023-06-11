class UserModel {
  final int id;
  final String email;
  final String uid;
  final String imageUrl;
  bool isVip;
  final String username;
  final String phone;
  final String address;

  UserModel({
    required this.id,
    required this.email,
    required this.uid,
    required this.isVip,
    required this.imageUrl,
    required this.username,
    required this.phone,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      uid: json['uid'],
      imageUrl: json['imageUrl'] ?? '',
      isVip: json['isVip'] ?? false,
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }
  // Copy with
  UserModel copyWith({
    int? id,
    String? email,
    String? uid,
    String? imageUrl,
    bool? isVip,
    String? username,
    String? phone,
    String? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      isVip: isVip ?? this.isVip,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  //To json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'uid': uid,
      'imageUrl': imageUrl,
      'isVip': isVip,
      'username': username,
      'phone': phone,
      'address': address,
    };
  }
}
