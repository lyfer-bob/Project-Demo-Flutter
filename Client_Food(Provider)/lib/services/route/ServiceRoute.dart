import 'package:flutter/material.dart';
import 'package:/SplashScreenPage.dart';
import 'package:/screen/AboutUs/AboutUsPage.dart';
import 'package:/screen/AboutUs/FAQPage.dart';
import 'package:/screen/AboutUs/Notification/notic_detail.dart';
import 'package:/screen/Fragment/Account/Authen/ForgorPassword/ChangePasswordOTPForgotPage.dart';
import 'package:/screen/Fragment/Account/Authen/ForgorPassword/sendForgotPassOTP.dart';
import 'package:/screen/Fragment/Account/Authen/ForgorPassword/validateForgotPassOTPPage.dart';
import 'package:/screen/Fragment/Account/Authen/Rigister/sendRegisOTP.dart';
import 'package:/screen/Fragment/Account/Authen/Rigister/validateRegisOTPPage.dart';
import 'package:/screen/Fragment/Account/Authen/SignInOTP/sendSignInOTP.dart';
import 'package:/screen/Fragment/Account/Authen/SignInOTP/validateSignInOTPPage.dart';
import 'package:/screen/Fragment/BasketPage/PayType/PayType.dart';
import 'package:/screen/Fragment/Account/Authen/SendPhoneNumberPage.dart';
import 'package:/screen/Fragment/BasketPage/PayType/component/CreditCard.dart';
import 'package:/screen/Fragment/BasketPage/PayType/component/MobileBankingPage.dart';
import 'package:/screen/Fragment/BasketPage/PayType/component/MobileBankingLoading.dart';
import 'package:/screen/Fragment/BasketPage/PayType/component/PromptpayQrCode.dart';
import 'package:/screen/Fragment/BasketPage/PayType/component/TrueMoneyWalletPage.dart';
import 'package:/screen/Fragment/BasketPage/PayType/component/TrueMoneyWalletWebView.dart';
import 'package:/screen/AboutUs/Notification/AllNotic.dart';
import 'package:/screen/AboutUs/Notification/NotificationPage.dart';
import 'package:/screen/AboutUs/Notification/ShowNoticPage.dart';
import 'package:/screen/AboutUs/ReferFriendPage.dart';
import 'package:/screen/AboutUs/TermsAndConditionsPage.dart';
import 'package:/screen/Fragment/Account/Account.dart';
import 'package:/screen/Fragment/Account/Authen/ChangePasswordPage.dart';
import 'package:/screen/Fragment/Account/Authen/ConfirmOTPPage.dart';
import 'package:/screen/Fragment/Account/Authen/ForgorPassword/ForgotPasswordPage.dart';
import 'package:/screen/Fragment/Account/Authen/Rigister/RegisterPage.dart';
import 'package:/screen/Fragment/Account/Authen/SignInPage.dart';
import 'package:/screen/Fragment/BasketPage/BasketPage.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDelivery.dart';
import 'package:/screen/Fragment/BasketPage/component/CouponDiscount.dart';
import 'package:/screen/Fragment/Fragment.dart';
import 'package:/screen/Fragment/MenuOrder/MenuOrder.dart';
import 'package:/screen/Fragment/RestaurantMain/Page/AllCategory.dart';
import 'package:/screen/Fragment/RestaurantMain/Page/SearchPage.dart';
import 'package:/screen/Fragment/RestaurantMain/Page/SelectTypeFood.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetail.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMain.dart';
import 'package:/screen/Fragment/RestaurantMain/SelectNumFoodOrder/SelectNumFoodOrder.dart';
import 'package:/screen/Profile/Address/component/AddressSelected.dart';
import 'package:/screen/Profile/AccountPage.dart';
import 'package:/screen/Profile/AccumulatedPointsPage.dart';
import 'package:/screen/Profile/Address/AddressSavePage.dart';
import 'package:/screen/Profile/Address/component/AddAddressPage.dart';
import 'package:/screen/Profile/Address/component/SearchAdress.dart';
import 'package:/screen/Profile/FavoriteShopPage.dart';
import 'package:/screen/TestPage/TestPage.dart';
import 'package:/screen/chat/ChatRoom.dart';
import 'package:/utils/ReasonForCancellationPage.dart';

final Map<String, WidgetBuilder> routes = {
  // '/authen': (BuildContext context) => Authen(),
  // '/splashScreen': (BuildContext context) => SplashScreenPage(),
  // '/mainPage': (BuildContext context) => MainPage(),
  // '/logInAuthen': (BuildContext context) => LogInAuthen(),
  '/signInPage': (BuildContext context) => SignInPage(),
  '/register': (BuildContext context) => RegisterPage(),
  '/forgotPassword': (BuildContext context) => ForgotPasswordPage(),
  '/confirmOTP': (BuildContext context) => ConfirmOTPPage(),
  '/changePassword': (BuildContext context) => ChangePasswordPage(),
  '/testPage': (BuildContext context) => TestPage(),
  '/fragment': (BuildContext context) => Fragment(),
  '/selectTypeFood': (BuildContext context) => SelectTypeFood(),
  '/restaurantMain': (BuildContext context) => RestaurantMain(),
  '/restaurantDetail': (BuildContext context) => RestaurantDetail(),
  '/basketPage': (BuildContext context) => BasketPage(),
  '/couponDiscount': (BuildContext context) => CouponDiscount(),
  '/payType': (BuildContext context) => PayType(),
  '/menuOrder': (BuildContext context) => MenuOrder(),
  '/detailDelivery': (BuildContext context) => DetailDelivery(),
  '/account': (BuildContext context) => Account(),
  '/selectNumFoodOrder': (BuildContext context) => SelectNumFoodOrder(),
  '/faq': (BuildContext context) => FAQPage(),
  '/aboutUs': (BuildContext context) => AboutUsPage(),
  '/termsAndConditions': (BuildContext context) => TermsAndConditionsPage(),
  '/referFriend': (BuildContext context) => ReferFriendPage(),
  '/addressSave': (BuildContext context) => AddressSavePage(),
  '/favoriteShop': (BuildContext context) => FavoriteShopPage(),
  '/accumulatedPoints': (BuildContext context) => AccumulatedPointsPage(),
  '/profile': (BuildContext context) => AccountPage(),
  '/addressSelected': (BuildContext context) => AddressSelected(),
  '/notification': (BuildContext context) => NotificationPage(),
  '/shownotification': (BuildContext context) => ShowAllNoticPage(),
  '/showNoticPage': (BuildContext context) => ShowNoticPage(),
  '/ReasonForCancellationPage': (BuildContext context) =>
      ReasonForCancellationPage(),
  '/splashScreenPage': (BuildContext context) => SplashScreenPage(),
  '/searchPage': (BuildContext context) => SearchPage(),
  '/addAddressPage': (BuildContext context) => AddAddressPage(),
  '/searchAdress': (BuildContext context) => SearchAdress(),
  '/sendPhoneNumber': (BuildContext context) => SendPhoneNumberPage(),
  '/creditCard': (BuildContext context) => CreditCard(),
  '/promptpayQrCode': (BuildContext context) => PromptpayQrCode(),
  '/trueMoneyWalletWebView': (BuildContext context) => TrueMoneyWalletWebView(),
  '/trueMoneyWalletPage': (BuildContext context) => TrueMoneyWalletPage(),
  '/mobileBankingPage': (BuildContext context) => MobileBankingPage(),
  '/mobileBankingLoading': (BuildContext context) => MobileBankingLoading(),
  '/noticDetail': (BuildContext context) => NoticDetail(),
  '/validateForgotPassOTP': (BuildContext context) =>
      ValidateForgotPassOTPPage(),
  '/sendForgotPassOTP': (BuildContext context) => SendForgotPassOTP(),
  '/changePasswordOTPForgot': (BuildContext context) =>
      ChangePasswordOTPForgotPage(),
  '/signInWithOTP': (BuildContext context) => SignInWithOTPPage(),
  '/validateSignInWithOTP': (BuildContext context) =>
      ValidateSignInWithOTPPage(),
  '/registerWithOTP': (BuildContext context) => RegisterWithOTPPage(),
  '/validateRegisterWithOTP': (BuildContext context) =>
      ValidateRegisterWithOTPPage(),
  '/allCategory': (BuildContext context) => AllCategory(),
  '/chatRoom': (BuildContext context) => ChatRoomPage(),
};
