import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/FromJSON/ChatArgumentModel.dart';
import '../../../services/route/ApiPath.dart';
import '../../../utils/Constants.dart';

class ChatArgumentProvider extends ChangeNotifier {
  ChatArgumentProvider();

  DatabaseReference? _chatRef = FirebaseDatabase.instance.ref("");

  DatabaseReference? _chatRefCustRest =
      FirebaseDatabase.instance.ref("messages-customer-restaurant");

  DatabaseReference? _chatRefCustRider =
      FirebaseDatabase.instance.ref("messages-customer-rider");

  StreamSubscription<DatabaseEvent>? _messagesSubscription;

  // This list holds the conversation
  List _chatMessages = [];

  TextEditingController text = TextEditingController();

  String? messageRecipientByApp;
  String? messageRecipientTopicsByApp;
  String? messageRecipientByAppAppBar;

  String? currentApp;

  bool? _isOpenChatRoom = false,
      _isHaveChatNoticCustomerRestaurant = false,
      _isHaveChatNoticCustomerRider = false;

  int _notiCountUnread = 0;

  List<String> _noticDataList = [];

  get chatRef {
    return _chatRef!.onValue;
  }

  get chatMessages {
    return _chatMessages;
  }

  clearChatMessageList() {
    _chatMessages = [];
    notifyListeners();
  }

  get noticDataList {
    return _noticDataList;
  }

  setNoticDataList(value) {
    _noticDataList = value;
  }

  get isOpenChatRoom {
    return _isOpenChatRoom;
  }

  setOpenChatRoom(bool value) {
    _isOpenChatRoom = value;
  }

  get notiCountUnread {
    return _notiCountUnread;
  }

  get isHaveChatNoticCustomerRestaurant {
    return _isHaveChatNoticCustomerRestaurant != null
        ? _isHaveChatNoticCustomerRestaurant
        : false;
  }

  setHaveChatNoticCustomerRestaurant(bool value) async {
    _isHaveChatNoticCustomerRestaurant = value;

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('CustomerRestaurant', value);

    notifyListeners();
  }

  get isHaveChatNoticCustomerRider {
    return _isHaveChatNoticCustomerRider != null
        ? _isHaveChatNoticCustomerRider
        : false;
  }

  setHaveChatNoticCustomerRider(bool value) async {
    _isHaveChatNoticCustomerRider = value;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('CustomerRider', value);

    notifyListeners();
  }

  setHaveChatNotic(bool value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    Constants().printColorMagenta('|||| setHaveChatNotic::: $currentApp ||||');
    Constants().printColorMagenta(
        '|||| _isHaveChatNoticRestaurantRider::: $_isHaveChatNoticCustomerRestaurant ||||');
    Constants().printColorMagenta(
        '|||| _isHaveChatNoticCustomerRider::: $_isHaveChatNoticCustomerRider ||||');

    if (currentApp == 'messages-restaurant-rider') {
      _isHaveChatNoticCustomerRestaurant = false;

      _preferences.setBool('CustomerRestaurant', false);
    } else if (currentApp == 'messages-customer-rider') {
      _isHaveChatNoticCustomerRider = false;
      _preferences.setBool('CustomerRider', false);
    }

    Constants().printColorMagenta(
        '|||| _isHaveChatNoticRestaurantRider::: $_isHaveChatNoticCustomerRestaurant ||||');
    Constants().printColorMagenta(
        '|||| _isHaveChatNoticCustomerRider::: $_isHaveChatNoticCustomerRider ||||');

    notifyListeners();
  }

  getHaveChatNoticFromPreference() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _isHaveChatNoticCustomerRestaurant =
        _preferences.getBool('CustomerRestaurant');
    _isHaveChatNoticCustomerRider = _preferences.getBool('CustomerRider');
  }

  Future<void> initFirebaseChat(List<String> argument) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    String? clientID = _preferences.getString('id').toString();

    _noticDataList = argument;

    Constants().printColorMagenta('||| _noticDataList: $_noticDataList |||');

    if (currentApp == _noticDataList[0]) {
    } else {
      _chatMessages = [];
    }

    if (_noticDataList[0] == 'messages-customer-restaurant') {
      messageRecipientByAppAppBar = 'ติดต่อร้านค้า';
      messageRecipientByApp = 'restaurant';
      messageRecipientTopicsByApp = 'APPSTORE';

      currentApp = 'messages-customer-restaurant';
    } else if (_noticDataList[0] == 'messages-customer-rider') {
      messageRecipientByAppAppBar = 'ติดต่อไรเดอร์';
      messageRecipientByApp = 'rider';
      messageRecipientTopicsByApp = 'APPRIDER';

      currentApp = 'messages-customer-rider';
    }

    bool isGetGolive = ApiPath().isGolive;

    if (isGetGolive) {
      //  PROD Server //
      _chatRef = FirebaseDatabase.instance.ref(
          "${_noticDataList[0].toString()}/${_noticDataList[2].toString()}");
      // such as 'messages-restaurant-rider/EH-BKK-220307-00001'

    } else {
      //  UAT Server //
      _chatRef = FirebaseDatabase.instance.ref(
          "${_noticDataList[0].toString()}_${ApiPath.routeEndpoint}/${_noticDataList[2].toString()}");
      // such as 'messages-restaurant-rider_${ApiPath.routeEndpoint}/EH-BKK-220307-00001'

    }

    _chatRef!.once().then(
      (value) {
        _chatMessages.clear();

        value.snapshot.children.forEach(
          (DataSnapshot element) {
            ChatArgumentModel _argumentModel =
                ChatArgumentModel.fromJson(element.value);

            Constants().printColorMagenta('|| START initFirebaseChat ||');

            if (_argumentModel.read == false) {
              String? tempSenderType =
                  _argumentModel.senderId!.split('_').first;

              Constants()
                  .printColorMagenta('|| tempSenderType::: $tempSenderType ||');

              if (tempSenderType == 'rider') {
                setHaveChatNoticCustomerRider(true);
              } else if (tempSenderType == 'restaurant') {
                setHaveChatNoticCustomerRestaurant(true);
              }
            } else {}

            _chatMessages.add(element.value);

            _chatMessages.sort(
              (a, b) => b['received_time'].compareTo(a['received_time']),
            );
          },
        );
      },
    );

    // _messagesSubscription = _chatRef!.onValue.listen(
    //   (DatabaseEvent event) {
    //     _chatMessages.clear();
    //
    //     event.snapshot.children.forEach(
    //       (DataSnapshot element) {
    //         ChatArgumentModel _argumentModel =
    //             ChatArgumentModel.fromJson(element.value);
    //
    //         Constants().printColorMagenta(
    //             '||||| initFirebaseChat:: ${_argumentModel.receiverId} |||||');
    //         // if (_argumentModel.read == false &&
    //         //     _argumentModel.receiverId == 'rider_$driverID') {
    //         //   setHaveChatNotic(true);
    //         // }
    //
    //         _chatMessages.add(element.value);
    //
    //         _chatMessages.sort(
    //           (a, b) => b['received_time'].compareTo(a['received_time']),
    //         );
    //       },
    //     );
    //   },
    // );
  }

  Future<Null> fetchReadChat() async {
    _chatRef!.once().then(
      (value) {
        value.snapshot.children.forEach(
          (DataSnapshot element) {
            ChatArgumentModel _argumentModel =
                ChatArgumentModel.fromJson(element.value);

            _chatRef!.child(element.ref.path.split('/').last.toString()).update(
              {
                'message': _argumentModel.message,
                'read': true,
                'received_time': _argumentModel.receivedTime,
                'receiver_id': _argumentModel.receiverId,
                'sender_id': _argumentModel.senderId,
              },
            ).then(
              (value) {
                Constants().printColorMagenta(
                    '||||| fetchFirebaseChat:: READ UPDATE |||||');
                //setHaveChatNotic(false);
              },
            );
          },
        );
      },
    );
  }

  Future<Null> fetchFirebaseChat() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    String? clientID = _preferences.getString('id').toString();

    _messagesSubscription = _chatRef!.onValue.listen(
      (DatabaseEvent event) {
        _chatMessages.clear();

        event.snapshot.children.forEach(
          (DataSnapshot element) {
            ChatArgumentModel _argumentModel =
                ChatArgumentModel.fromJson(element.value);

            if (_argumentModel.receiverId == 'customer_$clientID' &&
                _isOpenChatRoom.toString() == 'true' &&
                _argumentModel.senderId!.split('_').first.toString() ==
                    messageRecipientByApp) {
              _chatRef!
                  .child(element.ref.path.split('/').last.toString())
                  .update(
                {
                  'message': _argumentModel.message,
                  'read': true,
                  'received_time': _argumentModel.receivedTime,
                  'receiver_id': _argumentModel.receiverId,
                  'sender_id': _argumentModel.senderId,
                },
              ).then(
                (value) {
                  Constants().printColorMagenta(
                      '||||| fetchFirebaseChat:: READ UPDATE |||||');
                  //setHaveChatNotic(false);
                },
              );
            }

            _chatMessages.add(element.value);

            _chatMessages.sort(
              (a, b) => b['received_time'].compareTo(a['received_time']),
            );
          },
        );
      },
    );
  }

  Future<Null> sendFirebaseChat(String msg) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    String? clientID = _preferences.getString('id').toString();

    Constants().printColorMagenta('|?|??| sendFirebaseChatElement |?|?|?|');
    Constants()
        .printColorMagenta('|?|??| sender_id: customer_$clientID |?|?|?|');
    Constants().printColorMagenta(
        '|?|??| receiver_id: ${messageRecipientByApp}_${_noticDataList[1]} |?|?|?|');
    Constants().printColorMagenta(
        '|?|??| topic: android_${messageRecipientTopicsByApp}_${_noticDataList[1]} |?|?|?|');
    Constants().printColorMagenta('|?|??| orderid: $_noticDataList[1] |?|?|?|');
    Constants()
        .printColorMagenta('|?|??| orderSubject: $_noticDataList[2] |?|?|?|');
    Constants().printColorMagenta('|?|??| notitype: $currentApp |?|?|?|');

    _chatRef!.push().set(
      {
        'received_time': DateTime.now().millisecondsSinceEpoch,
        'sender_id': 'customer_$clientID',
        'receiver_id': '${messageRecipientByApp}_${_noticDataList[1]}',
        'message': '$msg',
        'read': false
      },
    );

    bool isGetGolive = ApiPath().isGolive;

    if (isGetGolive) {
      sendNotiMessage(
          'android_${messageRecipientTopicsByApp}_${_noticDataList[1]}',
          orderid: clientID,
          orderSubject: _noticDataList[2],
          notitype: currentApp,
          title: msg);

      sendNotiMessage('ios_${messageRecipientTopicsByApp}_${_noticDataList[1]}',
          orderid: clientID,
          orderSubject: _noticDataList[2],
          notitype: currentApp,
          title: msg);
    } else {
      sendNotiMessage(
          'android_${messageRecipientTopicsByApp}_${_noticDataList[1]}_${ApiPath.routeEndpoint}',
          orderid: clientID,
          orderSubject: _noticDataList[2],
          notitype: currentApp,
          title: msg);

      sendNotiMessage(
          'ios_${messageRecipientTopicsByApp}_${_noticDataList[1]}_${ApiPath.routeEndpoint}',
          orderid: clientID,
          orderSubject: _noticDataList[2],
          notitype: currentApp,
          title: msg);
    }
  }

  sendNotiMessage(String? topics,
      {String? orderid,
      String? orderSubject,
      String? notitype,
      String? title}) async {
    // topics = 'android_APPRIDER_35';
    orderSubject ??= '';
    title ??= '';
    final postUrl = 'https://fcm.googleapis.com/fcm/send';

    String toParams = "/topics/" + '$topics';

    final data = {
      "notification": {
        "body": title,
        "title": orderSubject,
        "sound": "default",
        "badge": "1",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
      "priority": "high",
      "data": {
        "orderid": "$orderid",
        "ordernumber": "$orderSubject",
        "notitype": "$notitype"
      },
      "to": "$toParams"
    };

    final headers = {'content-type': 'application/json', 'Authorization': ''};

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
// on success do
      print("true");
    } else {
// on failure do
      print("false");
    }
  }
}
