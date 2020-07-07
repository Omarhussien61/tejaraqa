class Config_Model {
  String baseUrl;
  String consumerKey;
  String consumerSecret;
  String login;
  String kGoogleApiKey;
  String local;

  Config_Model(
      {this.baseUrl,
        this.consumerKey,
        this.consumerSecret,
        this.login,
        this.kGoogleApiKey,
        this.local});

  Config_Model.fromJson(Map<String, dynamic> json) {
    baseUrl = json['Base_url'];
    consumerKey = json['consumer_key'];
    consumerSecret = json['consumer_secret'];
    login = json['Login'];
    kGoogleApiKey = json['kGoogleApiKey'];
    local = json ['local'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Base_url'] = this.baseUrl;
    data['consumer_key'] = this.consumerKey;
    data['consumer_secret'] = this.consumerSecret;
    data['Login'] = this.login;
    data['kGoogleApiKey'] = this.kGoogleApiKey;
    data['local'] = this.local;
    return data;
  }
}
