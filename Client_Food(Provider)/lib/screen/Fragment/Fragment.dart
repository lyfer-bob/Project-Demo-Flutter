import 'package:badges/badges.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/main.dart';
import 'package:/screen/AboutUs/Notification/ShowNoticPage.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/screen/chat/providers/ChatArgument_provider.dart';
import 'package:/services/firebaseMessageing.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Account/Account.dart';
import 'Account/Authen/SignInPage.dart';
import 'BasketPage/BasketPage.dart';
import 'BasketPage/BasketPageProvider.dart';
import 'FragmentProvider.dart';
import 'MenuOrder/MenuOrder.dart';
import 'RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'RestaurantMain/RestaurantMain.dart';
import 'RestaurantMain/RestaurantMainProvider.dart';

class Fragment extends StatefulWidget {
  @override
  _FragmentState createState() => _FragmentState();
}

class _FragmentState extends State<Fragment> with WidgetsBindingObserver {
  Location location = Location();
  bool _serviceEnabled = true;
  PermissionStatus _status = PermissionStatus.granted;

  String firebaseUserType = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataInit();
    });
    var authBloc = Provider.of<AuthBloc>(context, listen: false);

    authBloc.currentUser.listen(
      (firebaseUser) {
        if (firebaseUser != null) {
          print('FirebaseUser:: ${firebaseUser.providerData[0].providerId}');
          firebaseUserType = firebaseUser.providerData[0].providerId.toString();
        } else {
          print('NO FirebaseUser');
        }
      },
    );

    getPrefences();

    setlistenOnNotifications();

    WidgetsBinding.instance.addObserver(this);
    _requestPermissions();
  }

  getDataInit() async {
    await Provider.of<AddressSavePageProvider>(context, listen: false)
        .getAddress(context);
    await Provider.of<FragmentProvider>(context, listen: false)
        .intitdata(context);
    Provider.of<RestaurantMainProvider>(context, listen: false)
        .intitMainPage(context: context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  // check permissions when app is resumed
  // this is when permissions are changed in app settings outside of app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    print('_serviceEnabled::: $_serviceEnabled');

    if (state == AppLifecycleState.resumed &&
        _status != PermissionStatus.granted) {
      _requestPermissions();
    }
  }

  void _requestPermissions() async {
    // _serviceEnabled = await location.serviceEnabled();

    // Constants().printColorCyan('_serviceEnabled:::: $_serviceEnabled');

    // if (!_serviceEnabled) {
    //   print(
    //       '\x1B[35m serviceEnabled_in__requestPermissions[0] :: $_serviceEnabled \x1B[0m');
    //   _serviceEnabled = await location.requestService();
    // } else {}

    // _status = await location.hasPermission();

    // Constants().printColorCyan('_locationStatus:::: $_status');

    // if (_status == PermissionStatus.granted) {
    //   Constants().printColorGreen('_status:: $_status');

    //   Provider.of<AddressSavePageProvider>(context, listen: false)
    //       .getCurrentLocation(context: context);

    //   Provider.of<AddressSavePageProvider>(context, listen: false)
    //       .getAddress(context);

    //   setState(() {});
    //   return;
    // } else if (_status == PermissionStatus.deniedForever ||
    //     _status == PermissionStatus.denied) {
    //   Constants().printColorRed('_status:: $_status');

    //   locationPremission(
    //       context, "Please Allow to access this device's location.");
    //   return;

    // }

    _serviceEnabled = await location.serviceEnabled();

    print(
        '\x1B[33m serviceEnabled_in__requestPermissions :: $_serviceEnabled \x1B[0m');

    if (!_serviceEnabled) {
      print(
          '\x1B[35m serviceEnabled_in__requestPermissions[0] :: $_serviceEnabled \x1B[0m');
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print(
            '\x1B[36m serviceEnabled_in__requestPermissions[1] :: $_serviceEnabled \x1B[0m');
        return;
      }
    }

    _status = await location.hasPermission();

    Constants().printColorCyan('_locationStatus:::: $_status');

    if (_status == PermissionStatus.granted) {
      Constants().printColorGreen('$_status');
      if (_status != PermissionStatus.granted) {
        return;
      }
      setState(() {});
    } else if (_status == PermissionStatus.deniedForever ||
        _status == PermissionStatus.denied) {
      Constants().printColorRed('$_status');

      //normalDialog(context, "Please Allow to access this device's location.");

      _status = await location.requestPermission();

      Constants().printColorMagenta('$_status');

      if (_status == PermissionStatus.granted) {
        // setState(() {});

        Constants().printColorMagenta('fdasffffff:::::$_status');
        //Navigator.popUntil(context, ModalRoute.withName('/mainPage'));

        Provider.of<AddressSavePageProvider>(context, listen: false)
            .getAddress(context);

        setState(() {});

        return;
      } else {
        //normalDialog(context, "Please Allow to access this device's location.");
      }

      //setState(() {});
    }
  }

  getPrefences() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    String? clientID = _preferences.getString('id').toString();
    String? custDeviceId = _preferences.getString('custDeviceId').toString();

    if (clientID.isNotEmpty && custDeviceId.isNotEmpty) {
      FirebaseMessageingMethods().subscribeClient(context);
    } else {
      FirebaseMessageingMethods().unSubscribeClient(context);
    }
  }

  setlistenOnNotifications() {
    onNotifications.stream.listen(
      (event) async {
        print('::::::::::::$event');
        var noticData = event.toString().split('_');
        print(noticData);
        if (noticData[0] == 'order') {
          Navigator.pushNamed(context, '/showNoticPage');
        } else if (noticData[0] == 'messages-customer-restaurant' ||
            noticData[0] == 'messages-customer-rider') {
          Constants().printColorMagenta('|||| SELECT ITEM NOTIC CHAT ||||');

          // noticData.add('messages-customer-rider'); //type
          // noticData.add(pvd.model!.result!.driverDetail!.first.id.toString()); //anoter side chat
          // noticData.add(pvd.orderNumber);
          // noticData.add(pvd.orderDetail!.customerId!.toString());// me

          List<String> listChatREQ = [];

          listChatREQ.add(noticData[0].toString());
          listChatREQ.add(noticData[1].toString());
          listChatREQ.add(noticData[2].toString());
          listChatREQ.add(noticData[3].toString());

          Provider.of<ChatArgumentProvider>(context, listen: false)
              .initFirebaseChat(listChatREQ);

          bool chatRoom =
              await Provider.of<ChatArgumentProvider>(context, listen: false)
                  .isOpenChatRoom;

          if (chatRoom == false) {
            Constants()
                .printColorMagenta('||||||| CAN CREATE CHAT ROOM |||||||');

            Navigator.pushNamed(context, '/chatRoom');
          } else {
            Constants()
                .printColorMagenta('||||||| HAVE OPEN CHAT ROOM |||||||');
          }
        } else {
          print('noticData[0]:::: ${noticData[0]}');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<BasketPageProvider, FragmentProvider,
        RestaurantDetailProvider>(
      builder: (context, pvdBastket, pvdFrag, pvdRestDetail, child) =>
          WillPopScope(
        onWillPop: () {
          // ถ้ามาจากหน้าสั่งอาหารแล้วอยู่หน้าตะกร้า
          if (pvdBastket.flagPage == 'byBottomSheet' &&
              pvdFrag.currentIndex == 2) {
            pvdRestDetail.getRestaurantDetail(
                pvdBastket.model.restId.toString(), context);

            Navigator.pushNamed(context, '/restaurantDetail');
          }
          return Future.value(false);
        },
        child: Scaffold(
          body: Consumer<FragmentProvider>(
              builder: (context, pvd, child) => <Widget>[
                    RestaurantMain(),
                    MenuOrder(),
                    BasketPage(),
                    ShowNoticPage(),
                    // firebaseUserType == 'apple.com' ||
                    //         firebaseUserType == 'google.com' ||
                    pvd.stsSigin == true ? Account() : SignInPage(),
                  ].elementAt(pvd.currentIndex)),
          floatingActionButton: Consumer2<FragmentProvider, BasketPageProvider>(
            builder: (context, pvd, pvdBasket, child) => Visibility(
              visible: pvd.stsFlagButton,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FloatingActionButton(
                    shape:
                        BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.yellow.shade700,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(
                        IconImport.basketflagment,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      pvdBasket.checkInitPageby('byFragment');
                      pvd.changeIndexpage(2);
                    }),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Consumer2<FragmentProvider, BasketPageProvider>(
            builder: (context, pvd, pvdBasket, child) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: pvd.currentIndex,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.yellow.shade700,
                  unselectedItemColor: Colors.grey.withOpacity(.6),
                  selectedFontSize: 14,
                  unselectedFontSize: 14,
                  onTap: (value) {
                    pvd.changeIndexpage(value, context: context);
                    if (value == 2) pvdBasket.checkInitPageby('byFragment');
                  },
                  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(IconImport.home_line),
                      activeIcon:
                          Icon(IconImport.home_solid, color: Colors.amber),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconImport.menu_line),
                      activeIcon: Constants().menuActiveSvgIcon(),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon:
                          Icon(IconImport.basketflagment, color: Colors.white),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: notiIcon(statusActive: false),
                      activeIcon: notiIcon(statusActive: true),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconImport.user_line),
                      activeIcon:
                          Icon(IconImport.user_solid, color: Colors.amber),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget notiIcon({required bool statusActive}) {
    return Consumer2<GlobalURLProvider, FragmentProvider>(
        builder: (context, pvdGlobal, pvdFrag, child) => pvdFrag.stsSigin &&
                pvdGlobal.notifyCount > 0
            ? Badge(
                badgeColor: Colors.red,
                position: BadgePosition(
                  end: -2,
                  bottom: 12,
                ),
                badgeContent: Constants().fontStyleRegular(
                    '${pvdGlobal.notifyCount > 99 ? '99+' : pvdGlobal.notifyCount}',
                    fontSize: 10,
                    colorValue: Colors.white),
                child: statusActive
                    ? Icon(IconImport.noti_solid, color: Colors.amber, size: 28)
                    : Icon(IconImport.noti_line, size: 28))
            : statusActive
                ? Icon(IconImport.noti_solid, color: Colors.amber, size: 28)
                : Icon(IconImport.noti_line, size: 28));
  }
}
