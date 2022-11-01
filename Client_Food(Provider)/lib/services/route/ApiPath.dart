class ApiPath {
  static String routeEndpoint = 'uatcloud'; //*** prod - uat -  uatcloud***
  static String apiURL = '';
  static String globalApiURL = '';

  bool isGolive = false;
  bool isDev = false;

  static String ippopayGetorder = '${apiURL}ippopay-getorder';
  static String deviceCheck = '${apiURL}devicecheck';
  static String customerLogin = '${apiURL}CustomerLogin';
  static String customerSignUp = '${apiURL}CustomerSignUp';
  static String socialSignUp = '${apiURL}SocialLogin';
  static String forgetPassword = '${apiURL}ForgetPassword';

  static String referralList = '${apiURL}MyAccount';
  static String orderList = '${apiURL}MyAccount';
  static String orderDetail = '${apiURL}MyAccount';
  static String customerDetails = '${apiURL}MyAccount';
  static String changePassword = '${apiURL}MyAccount';
  static String addressBookList = '${apiURL}MyAccount';
  static String addressBookAdd = '${apiURL}MyAccount';
  static String profileUpdate = '${apiURL}MyAccount';
  static String addressBookDetails = '${apiURL}MyAccount';
  static String addressBookEdit = '${apiURL}MyAccount';
  static String addressBookStatus = '${apiURL}MyAccount';
  static String addressBookDelete = '${apiURL}MyAccount';
  static String orderReview = '${apiURL}MyAccount';
  static String paymentOmise = '${apiURL}MyAccount';
  static String drivingDistance = '${apiURL}MyAccount';
  static String getListBanking = '${apiURL}MyAccount';
  static String orderUpdate = '${apiURL}MyAccount';

  static String omiseAddCard = '${apiURL}MyAccount';
  static String omiseDeleteCard = '${apiURL}MyAccount';
  static String getOmiseCards = '${apiURL}MyAccount';

  static String searches = '${apiURL}Searches';
  static String menuDetails = '${apiURL}MenuDetails';
  static String getLocation = '${apiURL}GetLocation';
  static String deliveryCalculate = '${apiURL}DeliveryCalculate';
  static String checkDistance = '${apiURL}CheckDistance';

  static String restaurantTiming = '${apiURL}Checkout';
  static String addressBookListCheckout = '${apiURL}Checkout';
  static String voucherAdded = '${apiURL}Checkout';

  static String placeOrder = '${apiURL}PlaceOrder';
  static String restaurantDetails = '${apiURL}RestaurantDetails';
  static String productDetails = '${apiURL}ProductDetails';
  static String productSubAddon = '${apiURL}ProductSubAddon';
  static String siteSettings = '${apiURL}siteSettings';
  static String socialLogin = '${apiURL}SocialLogin';
  static String getRewards = '${apiURL}getRewards';
  static String rewardHistory = '${apiURL}rewardHistory';
  static String checkProfile = '${apiURL}checkProfile';
  static String logout = '${apiURL}Client/Logout';

  static String updateFavorite = '${apiURL}CustomerNew/requests';
  static String favoriteList = '${apiURL}CustomerNew/requests';
  static String voucherList = '${apiURL}CustomerNew/requests';

  static String configs = '$globalApiURL/configs';
  static String notifyList = '$globalApiURL/NotifyList';
  static String notifyCount = '$globalApiURL/NotifyCount';
  static String notifyUpdateRead = '$globalApiURL/NotifyUpdateRead';
  static String requestOTP = '$globalApiURL/RequestOTP';
  static String verifyOTP = '$globalApiURL/VerifyOTP';
  static String requestOTPForgot = '$globalApiURL/RequestOTPForgot';
  static String verifyOTPForgot = '$globalApiURL/VerfityOTPForgot';
  static String requestOTPLogin = '$globalApiURL/RequestOTPLogin';
  static String verifyOTPLogin = '$globalApiURL/VerifyOTPLogin';
  static String requestOTPRegister = '$globalApiURL/RequestOTPRegist';
  static String verifyOTPRegister = '$globalApiURL/VerifyOTPRegist';
  static String requestOTPProfileUpdate =
      '$globalApiURL/RequestOTPProfileUpdate';
  static String verfityOTPProfileUpdate =
      '$globalApiURL/VerfityOTPProfileUpdate';

  ApiPath();
}
