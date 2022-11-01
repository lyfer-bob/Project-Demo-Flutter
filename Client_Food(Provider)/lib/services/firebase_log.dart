import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseLog {
  CollectionReference? logData;
  Future<Future<DocumentReference<Map<String, dynamic>>>?> addLogDataToFirebase(
      {String? actionBy,
      String? clientID,
      String? orderId,
      String? body,
      String? restData}) async {
    orderId ??= '';
    if (ApiPath().isGolive) {
      logData = FirebaseFirestore.instance.collection('LogData');
    } else {
      ApiPath.routeEndpoint == 'uat'
          ? logData = FirebaseFirestore.instance.collection('LogData_UAT')
          : logData = FirebaseFirestore.instance.collection('LogData_UATCLOUD');
    }

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);
    String time = DateFormat('kk:mm:ss').format(now);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _appNameVersion = prefs.getString('version');
    String? _appPlatform = prefs.getString('platform');

    // print('Date : $date');
    // print('Time : $time');
    String whiteLog = prefs.getString('enableWriteLog')!;
    // Constants().printColorGreen(whiteLog);

    if (whiteLog == 'true') {
      return logData!.doc('ClientApp').collection('ClientDate_$date').add(
        {
          'id': '$clientID',
          'date': '$date',
          'time': '$time',
          'order_id': '$orderId',
          'actionBy': '$actionBy',
          'app_version': _appNameVersion,
          'app_platform': '$_appPlatform',
          'body': '$body',
          'restData': '$restData',
        },
      );
    } else {
      return null;
    }
  }

  FirebaseLog();
}
