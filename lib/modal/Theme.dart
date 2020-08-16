class ThemeModel {
  String imageSplash;
  String imageAppbar;
  String primaryCoustom;
  String background1;
  String background2;
  String mainFont;
  String titleFont;
  String subtitleFont;
  String titleSize;
  String subtitleSize;
  String iconFont;
  String local;
  List<String> mainICon;
  List<String> cartICon;
  List<String> searchICon;
  List<String> categoryICon;
  List<String> moreICon;
  List<String> accoantManagement;
  List<String> addressManagement;
  List<String> orderHistory;
  List<String> categoryList;
  List<String> logout;
  List<String> login;
  List<String> mainCategory;
  List<String> lastAdd;
  List<String> moreSale;
  List<String> sales;
  List<String> lastViewed;
  List<String> viewall;
  String cartPalceholder;
  List<String> cartTitle;
  List<String> cartEmpty;
  List<String> cartCheakout;
  List<String> cartTotal;
  List<String> cartTotalProduct;
  List<String> cost;
  List<String> discount;
  List<String> discountCode;
  List<String> discountApplay;
  List<String> sortBy;
  List<String> searchContent;
  List<String> placeholderCategory;
  List<String> prroductRate;
  List<String> prroductQuantity;
  List<String> prroductAddCart;
  List<String> prroductRelated;
  List<String> prroductditails;
  List<String> prroductComment;
  List<String> prroductAttrbuites;
  List<String> contanueShopping;
  List<String> gotoCart;
  List<String> yourComment;
  List<String> commentConfirm;

  ThemeModel(
      {this.imageSplash,
        this.imageAppbar,
        this.primaryCoustom,
        this.background1,
        this.background2,
        this.mainFont,
        this.titleFont,
        this.subtitleFont,
        this.titleSize,
        this.subtitleSize,
        this.iconFont,
        this.local,
        this.mainICon,
        this.cartICon,
        this.searchICon,
        this.categoryICon,
        this.moreICon,
        this.accoantManagement,
        this.addressManagement,
        this.orderHistory,
        this.categoryList,
        this.logout,
        this.login,
        this.mainCategory,
        this.lastAdd,
        this.moreSale,
        this.sales,
        this.lastViewed,
        this.viewall,
        this.cartPalceholder,
        this.cartTitle,
        this.cartEmpty,
        this.cartCheakout,
        this.cartTotal,
        this.cartTotalProduct,
        this.cost,
        this.discount,
        this.discountCode,
        this.discountApplay,
        this.sortBy,
        this.searchContent,
        this.placeholderCategory,
        this.prroductRate,
        this.prroductQuantity,
        this.prroductAddCart,
        this.prroductRelated,
        this.prroductditails,
        this.prroductComment,
        this.prroductAttrbuites,
        this.contanueShopping,
        this.gotoCart,
        this.yourComment,
        this.commentConfirm});

  ThemeModel.fromJson(Map<String, dynamic> json) {
    imageSplash = json['image_splash'];
    imageAppbar = json['image_appbar'];
    primaryCoustom = json['primary_Coustom'];
    background1 = json['background_1'];
    background2 = json['background_2'];
    mainFont = json['Main_font'];
    titleFont = json['title_font'];
    subtitleFont = json['subtitle_font'];
    titleSize = json['title_size'];
    subtitleSize = json['subtitle_size'];
    iconFont = json['Icon_font'];
    local = json['local'];
    mainICon = json['MainICon'].cast<String>();
    cartICon = json['CartICon'].cast<String>();
    searchICon = json['SearchICon'].cast<String>();
    categoryICon = json['CategoryICon'].cast<String>();
    moreICon = json['MoreICon'].cast<String>();
    accoantManagement = json['AccoantManagement'].cast<String>();
    addressManagement = json['AddressManagement'].cast<String>();
    orderHistory = json['OrderHistory'].cast<String>();
    categoryList = json['CategoryList'].cast<String>();
    logout = json['Logout'].cast<String>();
    login = json['Login'].cast<String>();
    mainCategory = json['MainCategory'].cast<String>();
    lastAdd = json['LastAdd'].cast<String>();
    moreSale = json['MoreSale'].cast<String>();
    sales = json['Sales'].cast<String>();
    lastViewed = json['LastViewed'].cast<String>();
    viewall = json['Viewall'].cast<String>();
    cartPalceholder = json['Cart_palceholder'];
    cartTitle = json['CartTitle'].cast<String>();
    cartEmpty = json['CartEmpty'].cast<String>();
    cartCheakout = json['CartCheakout'].cast<String>();
    cartTotal = json['cart_total'].cast<String>();
    cartTotalProduct = json['cart_total_product'].cast<String>();
    cost = json['Cost'].cast<String>();
    discount = json['discount'].cast<String>();
    discountCode = json['discount_code'].cast<String>();
    discountApplay = json['discount_applay'].cast<String>();
    sortBy = json['SortBy'].cast<String>();
    searchContent = json['SearchContent'].cast<String>();
    placeholderCategory = json['PlaceholderCategory'].cast<String>();
    prroductRate = json['PrroductRate'].cast<String>();
    prroductQuantity = json['PrroductQuantity'].cast<String>();
    prroductAddCart = json['PrroductAddCart'].cast<String>();
    prroductRelated = json['PrroductRelated'].cast<String>();
    prroductditails = json['Prroductditails'].cast<String>();
    prroductComment = json['PrroductComment'].cast<String>();
    prroductAttrbuites = json['PrroductAttrbuites'].cast<String>();
    contanueShopping = json['ContanueShopping'].cast<String>();
    gotoCart = json['gotoCart'].cast<String>();
    yourComment = json['yourComment'].cast<String>();
    commentConfirm = json['CommentConfirm'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_splash'] = this.imageSplash;
    data['image_appbar'] = this.imageAppbar;
    data['primary_Coustom'] = this.primaryCoustom;
    data['background_1'] = this.background1;
    data['background_2'] = this.background2;
    data['Main_font'] = this.mainFont;
    data['title_font'] = this.titleFont;
    data['subtitle_font'] = this.subtitleFont;
    data['title_size'] = this.titleSize;
    data['subtitle_size'] = this.subtitleSize;
    data['Icon_font'] = this.iconFont;
    data['local'] = this.local;
    data['MainICon'] = this.mainICon;
    data['CartICon'] = this.cartICon;
    data['SearchICon'] = this.searchICon;
    data['CategoryICon'] = this.categoryICon;
    data['MoreICon'] = this.moreICon;
    data['AccoantManagement'] = this.accoantManagement;
    data['AddressManagement'] = this.addressManagement;
    data['OrderHistory'] = this.orderHistory;
    data['CategoryList'] = this.categoryList;
    data['Logout'] = this.logout;
    data['Login'] = this.login;
    data['MainCategory'] = this.mainCategory;
    data['LastAdd'] = this.lastAdd;
    data['MoreSale'] = this.moreSale;
    data['Sales'] = this.sales;
    data['LastViewed'] = this.lastViewed;
    data['Viewall'] = this.viewall;
    data['Cart_palceholder'] = this.cartPalceholder;
    data['CartTitle'] = this.cartTitle;
    data['CartEmpty'] = this.cartEmpty;
    data['CartCheakout'] = this.cartCheakout;
    data['cart_total'] = this.cartTotal;
    data['cart_total_product'] = this.cartTotalProduct;
    data['Cost'] = this.cost;
    data['discount'] = this.discount;
    data['discount_code'] = this.discountCode;
    data['discount_applay'] = this.discountApplay;
    data['SortBy'] = this.sortBy;
    data['SearchContent'] = this.searchContent;
    data['PlaceholderCategory'] = this.placeholderCategory;
    data['PrroductRate'] = this.prroductRate;
    data['PrroductQuantity'] = this.prroductQuantity;
    data['PrroductAddCart'] = this.prroductAddCart;
    data['PrroductRelated'] = this.prroductRelated;
    data['Prroductditails'] = this.prroductditails;
    data['PrroductComment'] = this.prroductComment;
    data['PrroductAttrbuites'] = this.prroductAttrbuites;
    data['ContanueShopping'] = this.contanueShopping;
    data['gotoCart'] = this.gotoCart;
    data['yourComment'] = this.yourComment;
    data['CommentConfirm'] = this.commentConfirm;
    return data;
  }
}
