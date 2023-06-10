class UserModel {
  final int id;
  final String email;
  final String uid;
  final String imageUrl;
  bool isVip;
  final String username;

  UserModel({
    required this.id,
    required this.email,
    required this.uid,
    required this.isVip,
    required this.imageUrl,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      uid: json['uid'],
      imageUrl: json['imageUrl'] ?? '',
      isVip: json['isVip'] ?? false,
      username: json['username'] ?? '',
    );
  }
}
