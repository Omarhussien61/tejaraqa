class Product_variations {
  int id;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String description;
  String permalink;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  bool onSale;
  String status;
  bool purchasable;
  bool virtual;
  bool downloadable;
  int downloadLimit;
  int downloadExpiry;
  String taxStatus;
  String taxClass;
  bool manageStock;
  String stockStatus;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  String weight;
  Dimensions dimensions;
  String shippingClass;
  int shippingClassId;
  ImageVariation image;
  List<Attributes> attributes;
  int menuOrder;

  Product_variations(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.description,
        this.permalink,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,

        this.onSale,
        this.status,
        this.purchasable,
        this.virtual,
        this.downloadable,
        this.downloadLimit,
        this.downloadExpiry,
        this.taxStatus,
        this.taxClass,
        this.manageStock,
        this.stockStatus,
        this.backorders,
        this.backordersAllowed,
        this.backordered,
        this.weight,
        this.dimensions,
        this.shippingClass,
        this.shippingClassId,
        this.image,
        this.attributes,
        this.menuOrder,
      });

  Product_variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    description = json['description'];
    permalink = json['permalink'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];

    onSale = json['on_sale'];
    status = json['status'];
    purchasable = json['purchasable'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];

    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockStatus = json['stock_status'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    image = json['image'] != null ? new ImageVariation.fromJson(json['image']) : null;
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    menuOrder = json['menu_order'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['description'] = this.description;
    data['permalink'] = this.permalink;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;

    data['on_sale'] = this.onSale;
    data['status'] = this.status;
    data['purchasable'] = this.purchasable;
    data['virtual'] = this.virtual;
    data['downloadable'] = this.downloadable;

    data['download_limit'] = this.downloadLimit;
    data['download_expiry'] = this.downloadExpiry;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['stock_status'] = this.stockStatus;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions.toJson();
    }
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = this.menuOrder;


    return data;
  }
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ImageVariation {
  int id;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String src;
  String name;
  String alt;

  ImageVariation(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt});

  ImageVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class Attributes {
  int id;
  String name;
  String option;

  Attributes({this.id, this.name, this.option});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['option'] = this.option;
    return data;
  }
}



