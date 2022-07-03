class Branch {
  int? id;
  String? name;
  String? arname;
  String? desc;
  String? ardesc;
  double? lat;
  double? long;

  Branch(
      {this.id,
        this.name,
        this.arname,
        this.desc,
        this.ardesc,
        this.lat,
        this.long});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arname = json['arname'];
    desc = json['desc'];
    ardesc = json['ardesc'];
    lat = double.parse(json['lat'].toString());
    long = double.parse(json['long'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['arname'] = this.arname;
    data['desc'] = this.desc;
    data['ardesc'] = this.ardesc;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}