class CactusDetailModel {
  String managerId;
  String speMain;
  String speSup;
  String detail;
  String price;
  String imageCactus;
  String shopId;
  String shopname;
  String typeCactus;

  CactusDetailModel(
      {this.managerId,
      this.speMain,
      this.speSup,
      this.detail,
      this.price,
      this.imageCactus,
      this.shopId,
      this.shopname,
      this.typeCactus});

  CactusDetailModel.fromJson(Map<String, dynamic> json) {
    managerId = json['Manager_id'];
    speMain = json['Spe_main'];
    speSup = json['Spe_sup'];
    detail = json['Detail'];
    price = json['Price'];
    imageCactus = json['Image_cactus'];
    shopId = json['Shop_id'];
    shopname = json['Shopname'];
    typeCactus = json['Type_cactus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Manager_id'] = this.managerId;
    data['Spe_main'] = this.speMain;
    data['Spe_sup'] = this.speSup;
    data['Detail'] = this.detail;
    data['Price'] = this.price;
    data['Image_cactus'] = this.imageCactus;
    data['Shop_id'] = this.shopId;
    data['Shopname'] = this.shopname;
    data['Type_cactus'] = this.typeCactus;
    return data;
  }
}
