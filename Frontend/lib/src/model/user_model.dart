class UserModel {
  final String uid;
  final String name;
  final String email;
  final String dob;
  final String profilePic;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.dob,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      profilePic: json['profilePic'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dob': dob,
      'profilePic': profilePic,
    };
  }
}