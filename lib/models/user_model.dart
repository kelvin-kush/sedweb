class UserModel {
  String? id;
  String? profile;
  String? name;
  String? bio;
  List ?followers;
  List ?following;

  UserModel({
    this.id,
    this.profile,
    this.name,
    this.bio,
    this.followers,
    this.following,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      id: map['uid']??"",
      profile: map['profile']??"",
      name: map['username'],
     bio: map['bio']??"",
     followers: map['followers']??[],
     following: map['following']??[]
    );
  }
}
