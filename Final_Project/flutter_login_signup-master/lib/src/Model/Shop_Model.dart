class ShopModel {
  String shopId;
  String nameShop;
  String imageShop;
  String detail;
  String iDCard;
  String iD;
  String status;
  String username;

  ShopModel(
      {this.shopId,
      this.nameShop,
      this.imageShop,
      this.detail,
      this.iDCard,
      this.iD,
      this.status,
      this.username});

  ShopModel.fromJson(Map<String, dynamic> json) {
    shopId = json['Shop_id'];
    nameShop = json['Name_Shop'];
    imageShop = json['Image_Shop'];
    detail = json['Detail'];
    iDCard = json['ID_card'];
    iD = json['ID'];
    status = json['Status'];
    username = json['Username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Shop_id'] = this.shopId;
    data['Name_Shop'] = this.nameShop;
    data['Image_Shop'] = this.imageShop;
    data['Detail'] = this.detail;
    data['ID_card'] = this.iDCard;
    data['ID'] = this.iD;
    data['Status'] = this.status;
    data['Username'] = this.username;
    return data;
  }
}
