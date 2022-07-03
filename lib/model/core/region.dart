class Region {
  int? id;
  String? name;
  String? arname;

  Region({this.id, this.name, this.arname});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arname = json['arname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['arname'] = this.arname;
    return data;
  }
}