class faq_model {
  List<String> quastions;

  faq_model({this.quastions});

  faq_model.fromJson(Map<String, dynamic> json) {
    quastions = json['quastions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quastions'] = this.quastions;
    return data;
  }
}
