class SendReportModel {
  String iD;
  String shopName;
  String shopId;
  String reportSend;
  String token;

  SendReportModel(
      {this.iD, this.shopName, this.shopId, this.reportSend, this.token});

  SendReportModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    shopName = json['Shop_name'];
    shopId = json['Shop_id'];
    reportSend = json['report_send'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Shop_name'] = this.shopName;
    data['Shop_id'] = this.shopId;
    data['report_send'] = this.reportSend;
    data['Token'] = this.token;
    return data;
  }
}
