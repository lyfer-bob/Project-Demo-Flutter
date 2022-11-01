import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:/model/FromJSON/globalURLModel.dart';
import 'package:/model/FromJSON/noticCountModel.dart';
import 'package:/model/FromJSON/noticListModel.dart';
import 'package:/model/FromJSON/noticReadUpdateStatusModel.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalURLProvider extends ChangeNotifier {
  GlobalUrlModel? globalUrlModel;
  NoticCountModel? noticCountModel;
  ListNoticModel? listNoticModel;
  NoticReadUpdateStatusModel? readUpdateStatusModel;

  bool? _statusMaintenance;
  bool loadingStsNotiAll = false;
  bool loadingStsNotiProm = false;
  bool loadingStsNotiOrder = false;

  String? _urlAboutUS,
      _urlPolicy,
      _callCenterNumber,
      _termsPolicies,
      _fagcustomer,
      _textMaintenance,
      _maximumRequestTime,
      _acceptTime,
      _noticListStatus;

  int? _notifyCount;
  String? customerID;
  int pageLoad = 1;
  bool loadingLazySuccess = false;

  List<Items> _listNoticAll = [],
      _listNoticOrder = [],
      _listNoticNEWS = [],
      _listNoticPromAndNews = [];

  GlobalURLProvider();

  get urlAboutUS {
    return _urlAboutUS;
  }

  get urlPolicy {
    return _urlPolicy;
  }

  get callCenterNumber {
    return _callCenterNumber;
  }

  get termsPolicies {
    return _termsPolicies;
  }

  get fAQcustomer {
    return _fagcustomer;
  }

  get statusMaintenance {
    return _statusMaintenance;
  }

  get textMaintenance {
    return _textMaintenance;
  }

  get maximumRequestTime {
    return _maximumRequestTime;
  }

  get acceptTime {
    return int.parse(_acceptTime!);
  }

  get noticListStatus {
    return _noticListStatus;
  }

  int get notifyCount {
    return _notifyCount ?? 0;
  }

  List<Items> get listNoticAll {
    return _listNoticAll;
  }

  List<Items> get listNoticOrder {
    return _listNoticOrder;
  }

  List<Items> get listNoticNEWS {
    return _listNoticNEWS;
  }

  List<Items> get listNoticPromAndNews {
    return _listNoticPromAndNews;
  }

  getGlobalDataFromAPI() {
    aboutUSURL();
    policyURL();
    callCenterNo();
    termsPoliciesCustomer();
    fagCustomer();
    maintenanceText();
    noticUnreadAPI();
    noticListAPI();
  }

  enableWriteLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var body = {
        "key": "client_enable_write_log",
      };
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        prefs.setString('enableWriteLog', value['result']['value'].toString());
        Constants().printColorCyan(
            'WriteLog : ${value['result']['value'].toString()}');
        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_client_about_us:: $e');
    }
  }

  aboutUSURL() async {
    try {
      var body = {"key": "client_about_us"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);
        globalUrlModel!.status == "OK"
            ? _urlAboutUS = globalUrlModel!.result!.value
            : print('GlobalURL _urlAboutUS not OK!!');

        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_client_about_us:: $e');
    }
  }

  policyURL() async {
    try {
      var body = {"key": "customer_policy"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);
        globalUrlModel!.status == "OK"
            ? _urlPolicy = globalUrlModel!.result!.value
            : print('GlobalURL status not OK!!');

        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_customer_policy:: $e');
    }
  }

  callCenterNo() async {
    try {
      var body = {"key": "callcenter_number"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);
        globalUrlModel!.status == "OK"
            ? _callCenterNumber = globalUrlModel!.result!.value
            : print('GlobalURL status not OK!!');

        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_callcenter_number:: $e');
    }
  }

  termsPoliciesCustomer() async {
    try {
      var body = {"key": "customer_termcondition"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);
        globalUrlModel!.status == "OK"
            ? _termsPolicies = globalUrlModel!.result!.value
            : print('GlobalURL status not OK!!');

        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_customer_termcondition:: $e');
    }
  }

  fagCustomer() async {
    try {
      var body = {"key": "fag_customer"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);
        globalUrlModel!.status == "OK"
            ? _fagcustomer = globalUrlModel!.result!.value
            : print('GlobalURL status not OK!!');

        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_fag_customer:: $e');
    }
  }

  maintenanceStatusReturnValue() async {
    try {
      var body = {"key": "customer_maintenance"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);

        globalUrlModel!.status == "OK"
            ? globalUrlModel!.result!.value == 'true'
                ? _statusMaintenance = true
                : _statusMaintenance = false
            : print('GlobalURL status not OK!!');
        return _statusMaintenance;
        // notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_customer_maintenance:: $e');
    }
  }

  // rider_maintenance_text
  maintenanceText() async {
    try {
      var body = {"key": "customer_maintenance_text"};
      RestAPI().getData(url: ApiPath.configs, body: body).then((value) {
        globalUrlModel = GlobalUrlModel.fromJson(value);
        print(globalUrlModel!.result!.value);
        globalUrlModel!.status == "OK"
            ? _textMaintenance = globalUrlModel!.result!.value
            : print('GlobalURL status not OK!!');

        notifyListeners();
      });
    } catch (e) {
      print('ErrorFromGetGlobalURL_customer_maintenance_text:: $e');
    }
  }

  //notifyCount
  noticUnreadAPI() async {
    var preferences = await SharedPreferences.getInstance();
    customerID = preferences.getString('id').toString();

    try {
      var body = {
        "userid": customerID,
        "system": "Client",
      };
      RestAPI().getData(url: ApiPath.notifyCount, body: body).then(
        (value) {
          noticCountModel = NoticCountModel.fromJson(value);
          try {
            noticCountModel!.result!.success.toString() == "1"
                ? _notifyCount = noticCountModel!.result!.notifyUnreadCount!
                : print('GlobalURL status not OK!!');
          } catch (e) {
            print('error $e');
            print('GlobalURL status not OK!!');
          }

          notifyListeners();
        },
      );
    } catch (e) {
      print('ErrorFromGetGlobalURL_notifyCount:: $e');
    }
  }

  Future clearNoticModel() async {
    listNoticModel = null;
  }

  getNotiData(String flagPage) {
    _listNoticAll = [];
    _listNoticOrder = [];
    _listNoticPromAndNews = [];
    listNoticModel = null;
    loadingStsNotiAll = false;
    loadingStsNotiProm = false;
    loadingStsNotiOrder = false;
    loadingLazySuccess = true;
    pageLoad = 1;

    noticListAPI(flag: flagPage);
  }

  //notifyCount
  Future noticListAPI({String? flag}) async {
    flag ??= '';
    print('show flage $flag');
    var preferences = await SharedPreferences.getInstance();
    customerID = preferences.getString('id');

    Constants().printColorYellow(
        '|??| customerID From noticListAPI: $customerID |??|');

    String _group = flag == 'Order'
        ? "1"
        : flag == 'NewsAndProm'
            ? "2"
            : '';

    try {
      var body = {
        "userid": customerID,
        "system": "Client",
        "group_id": _group,
        "page_Size": 10,
        "page_current": pageLoad
      };
      await RestAPI().getData(url: ApiPath.notifyList, body: body).then(
        (value) {
          if (value['result']['success'] == 1) {
            ;
            listNoticModel = ListNoticModel.fromJson(value);
            if (flag == 'Order') {
              loadingStsNotiOrder = true;
              loadingStsNotiProm = false;
              loadingStsNotiAll = false;
              _listNoticOrder = getDataPage(_listNoticOrder);
            } else if (flag == 'NewsAndProm') {
              loadingStsNotiAll = false;
              loadingStsNotiOrder = false;
              loadingStsNotiProm = true;
              _listNoticPromAndNews = getDataPage(_listNoticPromAndNews);
            } else {
              loadingStsNotiAll = true;
              loadingStsNotiOrder = false;
              loadingStsNotiProm = false;
              _listNoticAll = getDataPage(_listNoticAll);
            }
          } else {
            if (pageLoad == 1) {
              if (flag == 'Order') {
                loadingStsNotiOrder = true;
                loadingStsNotiProm = false;
                loadingStsNotiAll = false;
              } else if (flag == 'NewsAndProm') {
                loadingStsNotiAll = false;
                loadingStsNotiOrder = false;
                loadingStsNotiProm = true;
              } else {
                loadingStsNotiAll = true;
                loadingStsNotiOrder = false;
                loadingStsNotiProm = false;
              }

              _listNoticOrder = [];
              _listNoticAll = [];
              _listNoticPromAndNews = [];
            }
            loadingLazySuccess = false;
          }
        },
      );

      notifyListeners();
    } catch (e, stack) {
      print('ErrorFromGetGlobalURL_noticListAPI:: $e');
      print('\x1B[33m$stack\x1B[0m');
    }
  }

  List<Items> getDataPage(List<Items> listModel) {
    List<Items> _listData = [];
    if (pageLoad == 1)
      _listData = listNoticModel!.result!.items!;
    else {
      listModel.addAll(listNoticModel!.result!.items!);
      _listData = listModel;
    }
    pageLoad++;
    loadingLazySuccess = true;

    return _listData;
  }

  //notifyUpdateRead
  Future notifyReadUpdateToAPI(int? noticID, String flagePage) async {
    noticID ??= 0;
    var preferences = await SharedPreferences.getInstance();
    customerID = preferences.getString('id');

    try {
      var body = {
        "userid": customerID,
        "system": "Client",
        "noti_id": noticID.toString(),
      };
      await RestAPI()
          .getData(url: ApiPath.notifyUpdateRead, body: body)
          .then((value) {
        readUpdateStatusModel = NoticReadUpdateStatusModel.fromJson(value);
        noticUnreadAPI();
      });

      print('client_accept_time:::::${globalUrlModel!.result!.success}');

      notifyListeners();
    } catch (e) {
      print('ErrorFromGetGlobalURLnotifyReadUpdateToAPI:: $e');
    }
  }

  launchURL(BuildContext context, String textURL) async {
    try {
      await launch(
        '$textURL',
        customTabsOption: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
