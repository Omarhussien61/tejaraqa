class Config_Model {
  String baseUrl;
  String consumerKey;
  String consumerSecret;
  bool login;
  String kGoogleApiKey;
  String local;
  int planIndex;
  List<String> sortHome;
  bool newProduct;
  bool searchtextbox;
  bool productCategories;
  bool slider;
  bool startScreen;
  bool productSale;
  bool customSection;
  bool topProduct;
  bool lowPriced;
  bool mostRecentlyLooked;
  bool register;
  bool userProfile;
  bool productListScreen;
  bool cartScreen;
  bool checkoutScreen;
  bool doneOrderScreen;
  bool orderHistoryScreen;
  bool productReviewingScreen;
  bool addressListScreen;
  bool favouriteListScreen;
  bool notification;
  bool googleMap;
  bool storeSettings;
  bool layout;
  bool fAQ;
  bool contactUs;
  bool aboutUs;
  bool support;
  bool cartItemsNotCompleted;
  bool storeOwner;
  bool offlineAppMode;

  Config_Model(
      {this.baseUrl,
        this.consumerKey,
        this.consumerSecret,
        this.login,
        this.kGoogleApiKey,
        this.local,
        this.planIndex,
        this.sortHome,
        this.newProduct,
        this.searchtextbox,
        this.productCategories,
        this.slider,
        this.startScreen,
        this.productSale,
        this.customSection,
        this.topProduct,
        this.lowPriced,
        this.mostRecentlyLooked,
        this.register,
        this.userProfile,
        this.productListScreen,
        this.cartScreen,
        this.checkoutScreen,
        this.doneOrderScreen,
        this.orderHistoryScreen,
        this.productReviewingScreen,
        this.addressListScreen,
        this.favouriteListScreen,
        this.notification,
        this.googleMap,
        this.storeSettings,
        this.layout,
        this.fAQ,
        this.contactUs,
        this.aboutUs,
        this.support,
        this.cartItemsNotCompleted,
        this.storeOwner,
        this.offlineAppMode});

  Config_Model.fromJson(Map<String, dynamic> json) {
    baseUrl = json['Base_url'];
    consumerKey = json['consumer_key'];
    consumerSecret = json['consumer_secret'];
    login = json['Login'];
    kGoogleApiKey = json['kGoogleApiKey'];
    local = json['local'];
    planIndex = json['Plan_index'];
    sortHome = json['SortHome'].cast<String>();
    newProduct = json['NewProduct'];
    searchtextbox = json['Searchtextbox'];
    productCategories = json['product_categories'];
    slider = json['Slider'];
    startScreen = json['StartScreen'];
    productSale = json['ProductSale'];
    customSection = json['Custom_section'];
    topProduct = json['Top_Product'];
    lowPriced = json['Low_Priced'];
    mostRecentlyLooked = json['Most_recently_looked'];
    register = json['Register'];
    userProfile = json['UserProfile'];
    productListScreen = json['Product_list_screen'];
    cartScreen = json['Cart_screen'];
    checkoutScreen = json['Checkout_screen'];
    doneOrderScreen = json['Done_order_screen'];
    orderHistoryScreen = json['Order_history_screen'];
    productReviewingScreen = json['Product_reviewing_screen'];
    addressListScreen = json['Address_list_screen'];
    favouriteListScreen = json['Favourite_list_screen'];
    notification = json['Notification'];
    googleMap = json['Google_map'];
    storeSettings = json['Store_Settings'];
    layout = json['Layout'];
    fAQ = json['FAQ'];
    contactUs = json['Contact_us'];
    aboutUs = json['About_us'];
    support = json['Support'];
    cartItemsNotCompleted = json['Cart_items_not_completed'];
    storeOwner = json['Store_owner'];
    offlineAppMode = json['Offline_app_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Base_url'] = this.baseUrl;
    data['consumer_key'] = this.consumerKey;
    data['consumer_secret'] = this.consumerSecret;
    data['Login'] = this.login;
    data['kGoogleApiKey'] = this.kGoogleApiKey;
    data['local'] = this.local;
    data['Plan_index'] = this.planIndex;
    data['SortHome'] = this.sortHome;
    data['NewProduct'] = this.newProduct;
    data['Searchtextbox'] = this.searchtextbox;
    data['product_categories'] = this.productCategories;
    data['Slider'] = this.slider;
    data['StartScreen'] = this.startScreen;
    data['ProductSale'] = this.productSale;
    data['Custom_section'] = this.customSection;
    data['Top_Product'] = this.topProduct;
    data['Low_Priced'] = this.lowPriced;
    data['Most_recently_looked'] = this.mostRecentlyLooked;
    data['Register'] = this.register;
    data['UserProfile'] = this.userProfile;
    data['Product_list_screen'] = this.productListScreen;
    data['Cart_screen'] = this.cartScreen;
    data['Checkout_screen'] = this.checkoutScreen;
    data['Done_order_screen'] = this.doneOrderScreen;
    data['Order_history_screen'] = this.orderHistoryScreen;
    data['Product_reviewing_screen'] = this.productReviewingScreen;
    data['Address_list_screen'] = this.addressListScreen;
    data['Favourite_list_screen'] = this.favouriteListScreen;
    data['Notification'] = this.notification;
    data['Google_map'] = this.googleMap;
    data['Store_Settings'] = this.storeSettings;
    data['Layout'] = this.layout;
    data['FAQ'] = this.fAQ;
    data['Contact_us'] = this.contactUs;
    data['About_us'] = this.aboutUs;
    data['Support'] = this.support;
    data['Cart_items_not_completed'] = this.cartItemsNotCompleted;
    data['Store_owner'] = this.storeOwner;
    data['Offline_app_mode'] = this.offlineAppMode;
    return data;
  }
}
