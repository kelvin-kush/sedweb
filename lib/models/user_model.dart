class UserModel {
  String? id;
  String? profile;
  String? name;
  String? bio;

  UserModel({
    this.id,
    this.profile,
    this.name,
    this.bio,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      id: map['uid'],
      profile: map['profile']??"",
      name: map['username'],
     bio: map['bio']??"",
    );
  }
}
