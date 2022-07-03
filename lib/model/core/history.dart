class History {
  int? id;
  int? status;
  String? name;
  String? arname;
  String? bName;
  String? bArname;
  double? lat;
  double? long;
  String? custName;
  String? custMobile;
  String? clientName;
  String? clientEmail;
  String? clientMobile;
  String? serName;
  String? serArname;
  String? estDate;
  String? endDate;
  String? date;
  String? number;
  String? logo;
  int? waitingCust;

  History(
      {this.id,
        this.status,
        this.name,
        this.arname,
        this.bName,
        this.bArname,
        this.lat,
        this.long,
        this.custName,
        this.custMobile,
        this.clientName,
        this.clientEmail,
        this.clientMobile,
        this.serName,
        this.serArname,
        this.estDate,
        this.endDate,
        this.date,
        this.number,
        this.logo,
        this.waitingCust});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    arname = json['arname'];
    bName = json['b_name'];
    bArname = json['b_arname'];
    lat = json['lat'] != null? double.parse(json['lat'].toString()):0;
    long = json['long'] != null? double.parse(json['long'].toString()):0;
    custName = json['cust_name'];
    custMobile = json['cust_mobile'];
    clientName = json['client_name'];
    clientEmail = json['client_email'];
    clientMobile = json['client_mobile'];
    serName = json['ser_name'];
    serArname = json['ser_arname'];
    estDate = json['est_date'];
    endDate = json['end_date'];
    date = json['date'];
    number = json['number'];
    logo = json['logo'];
    waitingCust = json['waiting_cust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['arname'] = this.arname;
    data['b_name'] = this.bName;
    data['b_arname'] = this.bArname;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['cust_name'] = this.custName;
    data['cust_mobile'] = this.custMobile;
    data['client_name'] = this.clientName;
    data['client_email'] = this.clientEmail;
    data['client_mobile'] = this.clientMobile;
    data['ser_name'] = this.serName;
    data['ser_arname'] = this.serArname;
    data['est_date'] = this.estDate;
    data['end_date'] = this.endDate;
    data['date'] = this.date;
    data['number'] = this.number;
    data['logo'] = this.logo;
    data['waiting_cust'] = this.waitingCust;
    return data;
  }
}