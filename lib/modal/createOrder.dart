class createOrder {
  String paymentMethod;
  String paymentMethodTitle;
  String   customer_id;
  bool setPaid;
  Billing billing;
  Shippings shipping;
  List<LineItems> lineItems;
  List<ShippingLines> shippingLines;
  List<coupon_lines> coupon_line;

  createOrder(
      {this.paymentMethod,
        this.paymentMethodTitle,
        this.customer_id,
        this.setPaid,
        this.billing,
        this.shipping,
        this.lineItems,
        this.shippingLines,
      this.coupon_line});

  createOrder.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    setPaid = json['set_paid'];
    billing =
    json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shippings.fromJson(json['shipping'])
        : null;
    if (json['line_items'] != null) {
      lineItems = new List<LineItems>();
      json['line_items'].forEach((v) {
        lineItems.add(new LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = new List<ShippingLines>();
      json['shipping_lines'].forEach((v) {
        shippingLines.add(new ShippingLines.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      coupon_line = new List<coupon_lines>();
      json['shipping_lines'].forEach((v) {
        coupon_line.add(new coupon_lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['customer_id'] = this.customer_id;
    if (this.billing != null) {
      data['billing'] = this.billing.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines.map((v) => v.toJson()).toList();
    }
    if (this.coupon_line != null) {
      if (this.coupon_line[0].code != null) {
        data['coupon_lines'] =
            this.coupon_line.map((v) => v.toJson()).toList();
      }
    }

    return data;
  }
}

class Billing {
  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  Billing(
      {this.firstName,
        this.lastName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country,
        this.email,
        this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Shippings {
  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  Shippings(
      {this.firstName,
        this.lastName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country});

  Shippings.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    return data;
  }
}

class LineItems {
  int productId;
  int variationId=0;
  int quantity;

  LineItems({
    this.productId, this.variationId, this.quantity
  });

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    if(this.variationId!=null){data['variation_id'] = this.variationId;}
    return data;
  }
}



class ShippingLines {
  String methodId;
  String methodTitle;
  String total;

  ShippingLines({this.methodId, this.methodTitle, this.total});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['total'] = this.total;
    return data;
  }
}
class coupon_lines {
  String code;

  coupon_lines({ this.code});

  coupon_lines.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.code!=null){
      data['code'] = this.code;
    }
    return data;
  }
}
