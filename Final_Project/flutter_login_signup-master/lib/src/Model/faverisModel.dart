class FaveritModel {
  String iD;
  String iDUser;
  String tokenUser;
  String iDShop;
  String nameShop;
  String tokenShop;

  FaveritModel(
      {this.iD,
      this.iDUser,
      this.tokenUser,
      this.iDShop,
      this.nameShop,
      this.tokenShop});

  FaveritModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDUser = json['ID_User'];
    tokenUser = json['Token_User'];
    iDShop = json['ID_Shop'];
    nameShop = json['Name_shop'];
    tokenShop = json['Token_Shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ID_User'] = this.iDUser;
    data['Token_User'] = this.tokenUser;
    data['ID_Shop'] = this.iDShop;
    data['Name_shop'] = this.nameShop;
    data['Token_Shop'] = this.tokenShop;
    return data;
  }
}
