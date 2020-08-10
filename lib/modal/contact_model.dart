class contact_model {
  String image;
  List<String> phone;
  List<String> email;

  contact_model({this.image, this.phone, this.email});

  contact_model.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    phone = json['phone'].cast<String>();
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
