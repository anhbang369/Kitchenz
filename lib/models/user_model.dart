class UserModel {
  final int id;
  final String email;
  final String uid;
  bool isVip;

  UserModel({
    required this.id,
    required this.email,
    required this.uid,
    required this.isVip,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      uid: json['uid'],
      isVip: json['isVip'] ?? false,
    );
  }
}
