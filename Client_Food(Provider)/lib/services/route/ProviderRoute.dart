import 'package:flutter/material.dart';
import 'package:/blocs/GetDeviceInfo_provider.dart';
import 'package:/blocs/forgetpassword_provider.dart';
import 'package:/blocs/login_provider.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/Account/Authen/provider/RigisterProvider.dart';
import 'package:/screen/Fragment/Account/Authen/provider/SignUpProvider.dart';
import 'package:/screen/Fragment/Account/provider/AccountProvider.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/screen/Fragment/MenuOrder/MenuOrderProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/screen/Profile/provider/AccumulatedPointsProvider.dart';
import 'package:/screen/Profile/provider/FavoriteShopProvider.dart';
import 'package:/screen/Profile/provider/ProfileCustomerProvider.dart';
import 'package:/screen/TestPage/provider/TestProvider.dart';
import 'package:/screen/chat/providers/ChatArgument_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> routeMultiProvider() {
  return [
    ChangeNotifierProvider(create: (_) => TestProvider()),
    ChangeNotifierProvider(create: (_) => RestaurantMainProvider()),
    ChangeNotifierProvider(create: (_) => RestaurantDetailProvider()),
    ChangeNotifierProvider(create: (_) => BasketPageProvider()),
    ChangeNotifierProvider(create: (_) => MenuOrderProvider()),
    ChangeNotifierProvider(create: (_) => DetailDeliveryProvider()),
    ChangeNotifierProvider(create: (_) => AccountProvider()),
    ChangeNotifierProvider(create: (_) => FragmentProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteShopProvider()),
    ChangeNotifierProvider(create: (_) => AddressSavePageProvider()),
    ChangeNotifierProvider(create: (_) => AccumulatedPointsProvider()),
    ChangeNotifierProvider(create: (_) => ProfileCustomerProvider()),
    ChangeNotifierProvider(create: (_) => SignUpProvider()),
    ChangeNotifierProvider(create: (_) => GlobalURLProvider()),
    ChangeNotifierProvider(create: (_) => GetDeviceInfoProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
    ChangeNotifierProvider(
      create: (BuildContext context) => RegisterProvider(),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => ChatArgumentProvider(),
    )
  ];
}
