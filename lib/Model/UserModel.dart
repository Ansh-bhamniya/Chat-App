class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? About;
  String? role;
  String? Status;

  UserModel({this.id, this.name, this.email, this.profileImage, this.phoneNumber, this.About, this.role, });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    profileImage = json["profileImage"];
    phoneNumber = json["phoneNumber"];
    About = json["About"];
    role = json["role"];
    Status = json["status"];

    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["profileImage"] = profileImage;
    data["phoneNumber"] = phoneNumber;
    data["About"] = About;
    data["role"] = role;
    data["Status"] = Status;
    return data;
  }
}
