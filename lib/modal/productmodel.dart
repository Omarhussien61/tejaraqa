import 'package:html/parser.dart' show parse;

class ProductModel {
  int id;
  String totalSales;
  String averageRating;
  String name;
  String stockStatus;
  String price;
  String priceHtml;
  String oldPrice;
  String status;
  String purchaseNote;
  String description;
  String salePrice;
  String sortDescription;
  List<Images> images;
  List<Categories> categories;
  List<attributes> attri;
  List<int> variations;
  List<int> related_ids;
  bool onSale;
  bool downloadable;
  bool purchasable;

  ProductModel(
      {this.id,
      this.name,
      this.stockStatus,
      this.price,
      this.images,
      this.priceHtml,
        this.oldPrice,
        this.totalSales,
      this.status,
      this.description,
      this.onSale,
      this.downloadable,
      this.purchasable,
      this.salePrice,
      this.purchaseNote,
      this.sortDescription,
        this.categories,
      this.averageRating,
      this.attri,
      this.variations,
      this.related_ids});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var list = json['images'] as List;
    var listcats = json['categories'] as List;

    var attributeList = json['attributes'] as List;
    var variationsList =json['variations'].cast<int>();
    var RealatedList =json['related_ids'].cast<int>() ;

    List<Categories> cats = listcats.map((i) => Categories.fromJson(i)).toList();

    List<Images> imagesList = list.map((i) => Images.fromJson(i)).toList();
    List<attributes> newAttributesList =
        attributeList.map((i) => attributes.fromJson(i)).toList();
    var shortdesc=parse(json['short_description']);

    var desc=parse(json['description']);

    // print(priceElement[0].text + " - "+ priceElement[1].text);

    return ProductModel(
        id: json['id'],
        name: json['name'],
        stockStatus: json['stock_status'],
        price: json['price'],
        images: imagesList,
        categories: cats,
        totalSales: json['total_sales'].toString(),
        status: json['status'],
        priceHtml: json['price_html'],
        oldPrice: json['regular_price'],
        description: desc.outerHtml,
        onSale: json['on_sale'],
        downloadable: json['downloadable'],
        purchasable: json['purchasable'],
        salePrice: json['sale_price'],
        sortDescription: shortdesc.outerHtml,
        averageRating: json['average_rating'],
       purchaseNote: json['purchase_note'],
        attri: newAttributesList,
      variations: variationsList,
      related_ids: RealatedList

    );
  }

}

class Images {
  String src;
  Images({this.src});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(src: json['src']);
  }
}
class Categories {
  int id;
  String name;
  String slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class attributes {
  int id;
  String name;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  attributes(
      {this.id,
        this.name,
        this.position,
        this.visible,
        this.variation,
        this.options});

  attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}

