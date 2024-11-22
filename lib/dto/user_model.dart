//  "avatar": "",
//   "email": "tommasodp50@gmail.com",
//   "instagram": "",
//   "isAdmin": false,
//   "isPromoter": false,
//   "name": "tommaso",
//   "promoterId": "00000000-0000-0000-0000-000000000000",
//   "surname": "de pellegrin",
//   "userId": "346a371f-1b1b-4a0e-96e8-52c38e711da4",
//   "username": "tommydep03"

class UserModel {
  String avatar;
  String email;
  String instagram;
  bool isAdmin;
  bool isPromoter;
  String name;
  String promoterId;
  String surname;
  String userId;
  String username;

  UserModel(
      {required this.avatar,
      required this.email,
      required this.instagram,
      required this.isAdmin,
      required this.isPromoter,
      required this.name,
      required this.promoterId,
      required this.surname,
      required this.userId,
      required this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json['avatar'],
      email: json['email'],
      instagram: json['instagram'],
      isAdmin: json['isAdmin'],
      isPromoter: json['isPromoter'],
      name: json['name'],
      promoterId: json['promoterId'],
      surname: json['surname'],
      userId: json['userId'],
      username: json['username'],
    );
  }
}
