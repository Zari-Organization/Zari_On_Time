class User {
  bool? status;
  int? custId;
  String? email;
  String? fullName;
  String? mobile;
  int? cityid;
  int? countryid;
  int? regionid;

  User(
      {this.status,
        this.custId,
        this.email,
        this.fullName,
        this.mobile,
        this.cityid,
        this.countryid,
        this.regionid});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    custId = json['cust_id'];
    email = json['email'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    cityid = json['cityid'];
    countryid = json['countryid'];
    regionid = json['regionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['cust_id'] = this.custId;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['mobile'] = this.mobile;
    data['cityid'] = this.cityid;
    data['countryid'] = this.countryid;
    data['regionid'] = this.regionid;
    return data;
  }
}