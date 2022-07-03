class Brand {
  int? id;
  String? name;
  String? arname;
  String? desc;
  String? ardesc;
  String? image;

  Brand({this.id, this.name, this.arname, this.desc, this.ardesc, this.image});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arname = json['arname'];
    desc = json['desc'];
    ardesc = json['ardesc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['arname'] = this.arname;
    data['desc'] = this.desc;
    data['ardesc'] = this.ardesc;
    data['image'] = this.image;
    return data;
  }
}