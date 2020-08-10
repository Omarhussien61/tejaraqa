class about_model {
  String image;
  List<String> item1;

  about_model({this.image, this.item1});

  about_model.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    item1 = json['item1'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['item1'] = this.item1;
    return data;
  }
}
