class UserLogin {
  String status;
  String cookie;
  String cookieName;
  UserM user;

  UserLogin({this.status, this.cookie, this.cookieName, this.user});

  UserLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cookie = json['cookie'];
    cookieName = json['cookie_name'];
    user = json['user'] != null ? new UserM.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['cookie'] = this.cookie;
    data['cookie_name'] = this.cookieName;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class UserM {
  int id;
  String username;
  String nicename;
  String email;
  String url;
  String registered;
  String displayname;
  String firstname;
  String lastname;
  String nickname;
  String description;
  String capabilities;
  String avatar;

  UserM(
      {this.id,
        this.username,
        this.nicename,
        this.email,
        this.url,
        this.registered,
        this.displayname,
        this.firstname,
        this.lastname,
        this.nickname,
        this.description,
        this.capabilities,
        this.avatar});

  UserM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nicename = json['nicename'];
    email = json['email'];
    url = json['url'];
    registered = json['registered'];
    displayname = json['displayname'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    nickname = json['nickname'];
    description = json['description'] != null
        ?json['description']
        : null;
    capabilities = json['capabilities'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nicename'] = this.nicename;
    data['email'] = this.email;
    data['url'] = this.url;
    data['registered'] = this.registered;
    data['displayname'] = this.displayname;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['nickname'] = this.nickname;
    data['description'] = this.description;
    if (this.capabilities != null) {
      data['capabilities'] = this.capabilities;
    }
    data['avatar'] = this.avatar;
    return data;
  }
}

class Capabilities {
  bool customer;

  Capabilities({this.customer});

  Capabilities.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    return data;
  }
}
