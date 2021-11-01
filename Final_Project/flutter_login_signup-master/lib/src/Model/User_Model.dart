class UserModel {
  String iDUser;
  String username;
  String email;
  String password;
  String imageProfile;
  String status;
  String token;

  UserModel(
      {this.iDUser,
      this.username,
      this.email,
      this.password,
      this.imageProfile,
      this.status,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    iDUser = json['ID_User'];
    username = json['Username'];
    email = json['Email'];
    password = json['Password'];
    imageProfile = json['Image_Profile'];
    status = json['Status'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iDUser;
    data['Username'] = this.username;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Image_Profile'] = this.imageProfile;
    data['Status'] = this.status;
    data['Token'] = this.token;
    return data;
  }
}
