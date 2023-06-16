import 'dart:io';
import 'dart:typed_data';
import 'package:ProjectName/model/FromJSON/VoucherListModel.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:/model/FromJSON/CreditCardListModel.dart';
import 'package:/model/FromJSON/DeliveryCalculateModel.dart';
import 'package:/model/FromJSON/DeliveryDistanceModel.dart';
import 'package:/model/FromJSON/GetListBankingModel.dart';
import 'package:/model/FromJSON/MenuDetailsModel.dart';
import 'package:/model/FromJSON/ProductDetails.dart';
import 'package:/model/FromJSON/ProductSubAddonModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/ModelView/BasketPageModel.dart';
import 'package:/model/FromJSON/GetRewardsModel.dart';
import 'package:/model/FromJSON/PlaceOrderResponse.dart';
import 'package:/model/FromJSON/VoucherListModel.dart';
import 'package:/model/Omise/OmiseResponseModel.dart';
import 'package:/model/ToJSON/PlaceOrderModel.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/services/firebase_log.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:omise_flutter/omise_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class BasketPageProvider extends ChangeNotifier {
  BasketPageProvider();

  TextEditingController textFieldRider = new TextEditingController();
  TextEditingController textFieldRest = new TextEditingController();
  TextEditingController textFieldTrueMoney = new TextEditingController();

  bool statusDiscountPoint = false;
  bool openByCheckoutPage = false;

  OmiseFlutter? omise; //uat
  OmiseResponseModel? promtPayQrCode;
  OmiseResponseModel? checkStatusPay;
  OmiseResponseModel? trueWallet;
  OmiseResponseModel? moblieBaking;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String omiseKey = '';
  String voucherType = '';
  bool isCvvFocused = false;
  String bankingtypeSelect = '';
  Uint8List? screenshotBytes;

  GetListBankingModel? listBanking;
  CreditCardListModel? creditCardListModel;
  DeliveryDistanceModel? deliveryDistanceModel;
  List<CardDetails>? creditCardList;
  String promptpayQrcodeUrl = '';
  Timer timerDuration = Timer.periodic(Duration(seconds: 2), (_) {});
  Timer timerDurationPayment = Timer.periodic(Duration(seconds: 2), (_) {});
  bool isInForeground = true;
  bool trueWalletValidate = true;
  bool colorCod = true,
      colorPromptpay = false,
      colorMobileBanking = false,
      colorTrueMoneyWallet = false,
      trueWalletLoading = false,
      mobileBakingLoading = false,
      promptpayLoading = false,
      isSuccessPPload = false,
      codPay = false,
      creditCardPay = false,
      trueWalletPay = false,
      mobileBakingPay = false,
      promptpayPay = false,
      isSubmit = false,
      isBuyingStatus = false,
      deliveryChargeSts = true,
      getPointSts = false;

  int systemErrorInit = 0,
      indexCreditCardSave = 0,
      rewardDiscout = 0,
      ordertotalprice = 0,
      orderIdResponse = 0;

  bool checkNullAdress = true;
  bool? stsCheckChangeRest;
  String flagPage = '';
  String couponeCode = 'ใส่รหัสส่วนลด';
  VoucherListModel? modelVoucher;
  GetRewardsModel? modelGetRewards;
  DeliveryCalculateModel? modelDelical;
  MenuDetailsModel? modelMenuDetail;
  List<VoucherList>? voucherList;
  int rewardPoint = 0, deliveryOri = 0, sumNumOrder = 0, discout = 0;
  double sumPriceOri = 0, ordderMinPriceOmise = 0;

  PlaceOrderResponse? orderRespModel;
  SuccessModel? successModel;

  String checkRestId = '';
  BasketPageModel model = new BasketPageModel();
  PlaceOrderModel placeOrderModel = new PlaceOrderModel(
      riderDescription: '',
      orderDescription: '',
      voucherCode: '',
      voucherAmount: 0,
      rewardPercentage: 0.00,
      ordertotalprice: 0.00,
      orderSubTotal: '',
      orderPoint: '',
      rewardPoint: '',
      cartdetails: []);

  Future<void> getDetailOrder({
    BasketPageModel? modelBasket,
  }) async {
    clearVoucher();

    model.paymentType = [];
    model = modelBasket!;

    notifyListeners();

    if (isBuyingStatus) sumOrderPrice();
  }

  Future intitdata() async {
    Constants().printColorCyan('|?| init qDATA in Basket Page |?|');
    if (placeOrderModel.paymentMethod == null) colorCod = true;

    deliveryChargeSts = true;
    systemErrorInit = 0;
    textFieldRest.text = placeOrderModel.orderDescription ?? '';
    textFieldRider.text = placeOrderModel.riderDescription ?? '';
    creditCardAddToken = '';
    var preferences = await SharedPreferences.getInstance();

    placeOrderModel.orderDevice = preferences.getString('platform');

    if (preferences.getString('id') != null &&
        preferences.getString('id') != '')
      placeOrderModel.customerId =
          int.parse(preferences.getString('id').toString());
    placeOrderModel.customerPhone = preferences.getString('phone');
    placeOrderModel.deliveryTime =
        DateFormat('hh:mm aaa').format(DateTime.now());
    // Fix ไว้ ยังไม่รู้
    placeOrderModel.deliveryDate =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    // Fix ไว้ ยังไม่รู้
    placeOrderModel.action = 'CheckOut';
    placeOrderModel.page = 'ConformOrder';
    placeOrderModel.appVersion = preferences.getString('version');
    placeOrderModel.customerType = 1; // fix ไว้ก่อน cr.พี่ป๊อป
    placeOrderModel.orderType = 'delivery'; // fix ไว้ก่อน
    placeOrderModel.paidFull = 'Yes'; // fix yes ไว้ก่อน ค่อย check no
    placeOrderModel.voucherPercentage = '0'; // Fix ไว้ ยังไม่มีใน Model Voucher
    placeOrderModel.taxPercentage = '0.00'; // Fix ไว้ ยังไม่มีการคำนวน
    placeOrderModel.taxAmount = '0.00'; // Fix ไว้ ยังไม่มีการคำนวน
    placeOrderModel.paymentName = ''; // Fix ไว้ ยังไม่รู้
    placeOrderModel.paymentMethod ??= 'cod'; // จ่ายเงินปลายทาง
    placeOrderModel.omiseCreditCardChoose = ''; //  ไว้กรณีมีการใช้ CreditCard
    placeOrderModel.tipamount = '0.00';
    placeOrderModel.rewardPoint = '';
    placeOrderModel.rewardPercentage = 0.00;
    placeOrderModel.assoonas = 'Now'; // -> Later
    placeOrderModel.transactionId = ''; // Fix ไว้ ยังไม่รู้
    placeOrderModel.paymentId = '';

    // check stspay
    codPay = false;
    creditCardPay = false;
    trueWalletPay = false;
    mobileBakingPay = false;
    promptpayPay = false;

    checkStsSubmit(false); // checkSubmitSt def false
    checkPaymentStatus(); // check id payment use
    getModeOmise(); // check mode omise
    getMinPriceOmise(); //get min buy omise
    getPointReward(); // get reward เพื่อดูคะแนนว่าพอแลก point ส่วนลดไหม

    if (preferences.getString('id') != null && model.restName != null) {
      isBuyingStatus = true;
      await getDrivingDistance();
      await getDeliveryCharge();
      sumOrderPrice();
    } else {
      isBuyingStatus = false;
      deliveryOri = 0;
    }

    Constants().printColorCyan('|?| completed DATA in Basket Page |?|');
  }

  //ตรวจสอบ Payment ที่สามารถทำการชำระเงินได้
  checkPaymentStatus() {
    if (model.paymentType != null) if (model.paymentType!.length != 0) {
      model.paymentType!.forEach((element) {
        switch (element) {
          case '60':
            codPay = true;
            break;
          case '61':
            creditCardPay = true;
            break;
          case '64':
            trueWalletPay = true;
            break;
          case '62':
            mobileBakingPay = true;
            break;
          case '63':
            promptpayPay = true;
            break;
          default:
        }
      });
    } else {
      print('log error ไม่มีการเลือกวิธีการชำระเงิน');
    }
  }

  Future getModeOmise() async {
    String modeOmise = '';
    try {
      await RestAPI().getData(url: ApiPath.configs, body: {
        "key": 'omise_mode'
      }).then((value) => modeOmise = value['result']['value']);
    } catch (e) {
      debugPrint('print error limit_store_storeproc = $e');
    }
    //check endpoint use omise
    if (modeOmise == 'Live')
      omiseKey = 'omise_live_publickey';
    else
      omiseKey = omiseKey = 'omise_test_publickey';
  }

  Future getMinPriceOmise() async {
    try {
      await RestAPI()
          .getData(url: ApiPath.configs, body: {"key": 'min_price_omise'}).then(
              (value) => ordderMinPriceOmise =
                  double.parse(value['result']['value'].toString()));
    } catch (e) {
      debugPrint('print error min_price_omise = $e');
    }
  }

  Future getPointReward() async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');

    if (preferences.getString('id') != null &&
        preferences.getString('id') != '') {
      var body = {"customer_id": customerId};
      RestAPI().getData(url: ApiPath.rewardHistory, body: body).then((value) {
        try {
          rewardPoint = int.parse(value['result']['totalPoints'].toString());
          FirebaseLog().addLogDataToFirebase(
              actionBy: 'rewardHistory',
              body: '$body',
              clientID: customerId,
              restData: '$value');
        } catch (e) {
          rewardPoint = 0;
          print('\x1B[33m error getPointReward $e\x1B[0m');
          FirebaseLog().addLogDataToFirebase(
              actionBy: 'rewardHistory',
              body: '$body',
              clientID: customerId,
              restData: '$e');
        }
      });
      notifyListeners();
    }
  }

  onSubmit(BuildContext context,
      {String? addressTitle, String? addressId}) async {
    if (listBasket.length == 0) {
      normalDialog(context, 'กรุณาเพิ่มเมนูอาหาร', text: 'ปิด');
    } else if (await checkPhoneNumber()) {
      normalDialog(context, 'กรุณาเพิ่มเบอร์โทรศัพท์',
          text: 'ตกลง',
          onPressed: () => Navigator.pushNamed(context, '/profile'));
    } else if (model.latitudeCust.toString().isEmpty ||
        model.longitudeCust.toString().isEmpty) {
      normalDialog(context, 'กรุณาเพิ่มที่อยู่การจัดส่ง', text: 'ปิด',
          onPressed: () {
        openbyCheckoutPageSts(true);
        Navigator.popAndPushNamed(context, '/addressSelected');
      });
    } else {
      Constants().dialogProgress(context);
      await getDrivingDistance(); // check Distane
      await getDeliveryCharge();

      sumOrderPrice();

      Constants().dialogProgress(context, pop: true);

      if (deliveryDistanceModel!.result!.success.toString() == "0") {
        normalDialog(
            context, 'พบข้อผิดพลาดในการคำนวณระยะทาง กรุณาลองใหม่อีกครั้ง',
            text: 'ตกลง', onPressed: () {
          Navigator.pop(context);
          isSubmit = false;
        });
      } else {
        if (addressTitle == 'ที่อยู่ปัจจุบัน') addressId = '';
        placeOrderModel.deliveryId = addressId;
        placeOrderModel.addressTitle = addressTitle;
        // แลกส่วนลด
        if (statusDiscountPoint &&
            ((model.sumPriceOrderTotal! -
                    double.parse(
                        modelDelical!.result!.deliveryCost.toString())) >=
                double.parse(model.rewardMinBuy.toString()))) {
          placeOrderModel.rewardPoint = Constants().priceDecimal(rewardDiscout);
          placeOrderModel.rewardPercentage =
              double.parse(model.rewardPerc.toString());
        }

        if (model.offerPercenStatus!) placeOrderModel.paidFull = "No";

        Navigator.pushNamed(context, '/payType');
      }
    }
  }

  clearAndGetListCoupon() {
    voucherList = null;
    notifyListeners();

    getCoupon();
  }

  Future<bool> checkPhoneNumber() async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "customer_id": preferences.getString('id'),
      "action": "MyAccount",
      "page": "CustomerDetails"
    };

    bool _phoneSts = true;

    await RestAPI()
        .getData(url: ApiPath.customerDetails, body: body)
        .then((value) => {
              Constants().printColorBlue(
                  'show phoneNumner = ${value['result']['customerPhone']}'),
              if (value['result']['customerPhone'] != null &&
                  value['result']['customerPhone'].toString().isNotEmpty)
                _phoneSts = false
              else
                _phoneSts = true
            });
    return _phoneSts;
  }

  Future getCoupon() async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "voucherList",
      "customer_id": preferences.getString('id'),
      "subTotal": sumPriceOri.toString(),
      "deliveryAmt": deliveryOri.toString()
    };
    try {
      var constants = Constants();

      RestAPI().getData(url: ApiPath.voucherList, body: body).then((value) {
        modelVoucher = VoucherListModel.fromJson(value);
        voucherList = modelVoucher!.result!.voucherList ?? [];

        for (var i = 0; i < voucherList!.length; i++) {
          voucherList![i].voucherTo = constants.dateTimeTHFormat(
              dateTime: modelVoucher!.result!.voucherList![i].voucherTo!,
              formatDate: 'dd-MM-yyyy',
              dateOnly: true);

          switch (voucherList![i].offerMode!) {
            case 'free_delivery': //ส่งฟรี
              voucherList![i].offerText = 'ส่งฟรี';
              voucherList![i].offerDesc = '';
              break;
            case 'percentage': //ส่วนลดเป็น percent
              voucherList![i].offerText = 'ส่วนลด';
              voucherList![i].offerDesc =
                  '**ส่วนลด ${voucherList![i].offerValue}% สูงสุด ${voucherList![i].maximumOrder} บาท';
              break;
            case 'price': //ส่วนลดธรรมดา
              voucherList![i].offerText = 'ส่วนลด';
              voucherList![i].offerDesc =
                  '**ส่วนลด ${voucherList![i].offerValue} บาท';
              break;
          }
        }

        notifyListeners();
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'voucherList',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'voucherList',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future getReward() async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "customer_id": preferences.getString('id'),
      "resid": model.restId.toString(),
      "subTotal": (model.sumPriceOrder! + discout).toString(),
      "grandTotal": model.sumPriceOrderTotal.toString()
    };
    try {
      RestAPI().getData(url: ApiPath.getRewards, body: body).then((value) {
        modelGetRewards = GetRewardsModel.fromJson(value);
        getPointSts = true;
        placeOrderModel.orderPoint =
            modelGetRewards!.result!.earnPoint.toString();

        notifyListeners();
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'getRewards',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'getRewards',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future getDeliveryCharge({BuildContext? context}) async {
    modelDelical = null;
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "customer_ref_id": preferences.getString('id'),
      "restaurant_ref_id": model.restId!.toString(),
      "delivery_distance": deliveryDistanceModel!.result!.deliverDistance,
      "time_map": deliveryDistanceModel!.result!.timeMap,
      "date_order": DateTime.now().toString()
    };
    try {
      await RestAPI()
          .getData(url: ApiPath.deliveryCalculate, body: body)
          .then((value) {
        modelDelical = DeliveryCalculateModel.fromJson(value);
        deliveryOri = modelDelical!.result!.deliveryCost ?? 0;
        deliveryChargeSts = true;

        FirebaseLog().addLogDataToFirebase(
            actionBy: 'deliveryCalculate',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
      if (context != null) {
        Navigator.pop(context, true);
        openbyCheckoutPageSts(false); // set default
      }

      notifyListeners();
    } catch (e) {
      modelDelical = null;
      deliveryChargeSts = false;
      notifyListeners();
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'deliveryCalculate',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future onChangeAddressSubmit(
      {String? addressTitle,
      String? addressId,
      required BuildContext? context,
      String? latitude,
      String? longtitude,
      String? flag}) async {
    placeOrderModel.addressTitle = addressTitle;
    placeOrderModel.deliveryId = addressId;
    model.latitudeCust = latitude;
    model.longitudeCust = longtitude;

    String _flag = flag ?? '';

    if (_flag == 'ChangeForBuy') {
      await getDrivingDistance(); // check Distane
      await getDeliveryCharge();
      sumOrderPrice();

      if (deliveryDistanceModel!.result!.success.toString() == "0") {
        Navigator.pop(context!); // pop Dialog
        normalDialog(
            context, 'พบข้อผิดพลาดในการคำนวณระยะทาง กรุณาลองใหม่อีกครั้ง',
            text: 'ตกลง', onPressed: () => Navigator.pop(context));
      } else {
        Navigator.pop(context!); // pop Dialog
      }
    } else {
      await getDrivingDistance();
      await getDeliveryCharge(context: context);

      sumOrderPrice();
    }
  }

  checkStsSubmit(bool value, {bool initPage = false}) {
    isSubmit = value;
    if (!initPage) notifyListeners();
  }

  Future getDrivingDistance() async {
    //get address
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "customer_id": preferences.getString('id'),
      "action": "MyAccount",
      "page": "getDrivingDistance",
      "latitudeFrom": model.latitudeRest.toString().trim(),
      "longitudeFrom": model.longitudeRest.toString().trim(),
      "latitudeTo": model.latitudeCust.toString().trim(),
      "longitudeTo": model.longitudeCust.toString().trim()
    };

    try {
      await RestAPI()
          .getData(url: ApiPath.drivingDistance, body: body)
          .then((value) {
        deliveryDistanceModel = DeliveryDistanceModel.fromJson(value);
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'drivingDistance',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'drivingDistance',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future<bool> checkRestCurrentStatus(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    bool _status = true;
    var body = {
      "customer_id": preferences.getString('id'),
      "resId": model.restId!,
      "address": preferences.getString('address')
    };
    await RestAPI()
        .getData(url: ApiPath.menuDetails, body: body)
        .then((value) async {
      modelMenuDetail = MenuDetailsModel.fromJson(value);
      if (modelMenuDetail!.result!.restDetails!.currentStatus!.toUpperCase() ==
          'OPEN') {
        _status = true;
      } else
        _status = false;
      notifyListeners();
    });
    return _status;
  }

  Future onSubmitOrder(BuildContext context) async {
    if (placeOrderModel.deliveryId == null ||
        placeOrderModel.deliveryId == '') {
      checkNullAdress = false;
      Constants().dialogProgress(context, pop: true);
      normalDialog(context, 'กรุณาเพิ่มที่อยู่การจัดส่ง', text: 'ปิด',
          onPressed: () {
        openbyCheckoutPageSts(true);
        isSubmit = false;
        Navigator.popAndPushNamed(context, '/addressSelected');
      });
    } else {
      checkNullAdress = true;
      //Deli

      placeOrderModel.offerAmount = model.offerAmount;
      placeOrderModel.offerPercentage = model.offerPercentage;
      placeOrderModel.deliveryDistance =
          deliveryDistanceModel!.result!.deliverDistance;
      placeOrderModel.timeMap = deliveryDistanceModel!.result!.timeMap;
      placeOrderModel.resid = model.restId.toString();
      placeOrderModel.deliveryCharge =
          modelDelical!.result!.deliveryCost.toString();
      placeOrderModel.driverIncome =
          modelDelical!.result!.riderIncome.toString();
      placeOrderModel.deliveryCost = deliveryOri.toString();
      placeOrderModel.refNo = modelDelical!.result!.refNo;

      //Order
      placeOrderModel.cartdetails!.clear();
      for (var i = 0; i < listBasket.length; i++) {
        placeOrderModel.cartdetails!.add(new Cartdetails(
            addonName: listBasket[i].menuDetail ?? '',
            addonPrice: listBasket[i].addonPrice.toString(),
            menuId: listBasket[i].menuId,
            menuName: listBasket[i].menuHeader,
            menuPrice: listBasket[i].menuPriceOrginal.toString(),
            menuSize: listBasket[i].menuSize,
            menuType: listBasket[i].menuType,
            quantity: listBasket[i].menuNum.toString(),
            resId: model.restId,
            total: listBasket[i].menuSumPrice.toString(),
            instruction: ''));
      }
      if (placeOrderModel.paymentMethod == 'omise_credit_card') {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) =>
                SpinKitPouringHourGlass(color: Colors.amber, size: 125));
      }
      if (placeOrderModel.paymentMethod == 'promptpay') {
        promptpayLoading = false;
        notifyListeners();
        Navigator.popAndPushNamed(context, '/promptpayQrCode');
        submitPromptpayQrCode(context);
      } else if (placeOrderModel.paymentMethod == 'truemoney_wallet') {
        Navigator.popAndPushNamed(context, '/trueMoneyWalletPage');
      } else if (placeOrderModel.paymentMethod == 'mobile_banking') {
        Navigator.popAndPushNamed(context, '/mobileBankingPage');
      } else {
        submitPlaceOrder(context);
      }
    }
  }

  Future submitPlaceOrder(BuildContext context) async {
    bool _checkStatus = placeOrderModel.paymentMethod == 'omise_credit_card' ||
        placeOrderModel.paymentMethod == 'cod';

    if (placeOrderModel.paymentMethod == 'cod') {
      Navigator.popAndPushNamed(context, '/detailDelivery');
    }

    //check use offerDiscount
    if ((model.offerPercenStatus! &&
            double.parse((model.offerAmount ?? '0')) > 0) &&
        model.offerPercenStatus!)
      placeOrderModel.offerId = model.offerId;
    else
      placeOrderModel.offerId = '';

    await RestAPI()
        .getData(url: ApiPath.placeOrder, body: placeOrderModel.toJson())
        .then(
      (value) async {
        if (value['result']['success'].toString() == "1") {
          bool _checkstatusCreditPay = true;
          if (placeOrderModel.paymentMethod == 'omise_credit_card') {
            if (value['result']['result_credit_card']) {
              _checkstatusCreditPay = true;
              Navigator.popAndPushNamed(context, '/detailDelivery');
            } else {
              Navigator.pop(context); // pop loading
              isSubmit = false;
              _checkstatusCreditPay = false;
              notifyListeners();

              normalDialog(context, value['result']['message'].toString(),
                  text: 'ปิด');
            }
          }
          //add log
          Constants().printColorGreen('addlogSubmit placeOrder');
          var preferences = await SharedPreferences.getInstance();
          FirebaseLog().addLogDataToFirebase(
              actionBy: 'placeOrder',
              orderId: '${value['result']['order_id'].toString()}',
              body: '${placeOrderModel.toJson()}',
              clientID: preferences.getString('id'),
              restData: '$value');

          orderIdResponse = 0;
          ordertotalprice = 0;
          if (checkNullAdress) {
            isSubmit = false;

            //check clear order creditcard and cod
            if (_checkStatus && _checkstatusCreditPay)
              clearDataMenuOrder(context);
            if (_checkStatus) {
              // credit card and cod
              Provider.of<DetailDeliveryProvider>(context, listen: false)
                  .getDataByOrderList(
                      int.parse(value['result']['order_id'].toString()));
            } else {
              ordertotalprice =
                  (placeOrderModel.ordertotalprice! * 100).toInt();
              orderIdResponse =
                  int.parse(value['result']['order_id'].toString());
            }
          }
        } else {
          Navigator.pop(context); // pop loading

          normalDialog(
            context,
            '${value['result']['message']}',
          );
          isSubmit = false;
          notifyListeners();

          var preferences = await SharedPreferences.getInstance();
          // expec value
          //add log
          Constants().printColorRed('addlogError placeOrder');

          FirebaseLog().addLogDataToFirebase(
              actionBy: 'placeOrder',
              orderId: '${value['result']['order_id'].toString()}',
              body: '${placeOrderModel.toJson()}',
              clientID: preferences.getString('id'),
              restData: '$value');
        }
      },
    );
  }

  clearDataMenuOrder(BuildContext context, {bool logoutSts = false}) {
    Constants().printColorBlue("|| START TASK CLEAR DATA AFTER LOG OUT ||");

    // ถ้าเป็น truewallet && moblie ให้เคีลยร์หลัังจากทำออเดอร์ success แล้ว

    String paymentMethod = placeOrderModel.paymentMethod ?? 'cod';

    clearVoucher();
    clearBottomsheetAndEndTimeQrCode();
    Provider.of<RestaurantDetailProvider>(context, listen: false)
        .changeStatusBottomSheet(false);

    model = new BasketPageModel();
    placeOrderModel = new PlaceOrderModel(
        riderDescription: '',
        orderDescription: '',
        voucherCode: '',
        voucherAmount: 0,
        rewardPercentage: 0.00,
        addressTitle: '',
        deliveryId: '',
        cartdetails: []);

    modelDelical = null;
    modelGetRewards = null;
    checkRestId = '';
    statusDiscountPoint = false;

    //check click to logout
    if (logoutSts) {
      //change to cod
      placeOrderModel.paymentMethod = 'cod';
      if (creditCardList != null) {
        creditCardList!.forEach(
          (element) {
            element.statusSelect = false;
          },
        );
      }

      placeOrderModel.omiseCreditCardChoose = '';
      colorPromptpay = false;
      colorTrueMoneyWallet = false;
      colorMobileBanking = false;
      colorCod = true;
    } else {
      //def payment method
      placeOrderModel.paymentMethod = paymentMethod;
    }

    Constants().printColorBlue("|| TASK CLEAR DATA AFTER LOG OUT IS DONE ||");
    notifyListeners();
  }

  sumOrderPrice() {
    if (deliveryChargeSts) modelDelical!.result!.deliveryCost = deliveryOri;

    if (voucherType == 'free_delivery') {
      modelDelical!.result!.deliveryCost = 0;
    }

    model.sumPriceOrder = 0;
    sumNumOrder = 0;

    for (var i = 0; i < listBasket.length; i++) {
      sumNumOrder += listBasket[i].menuNum!;

      listBasket[i].menuSumPrice =
          listBasket[i].menuNum! * listBasket[i].menuPrice!;

      model.sumPriceOrder = model.sumPriceOrder! + listBasket[i].menuSumPrice!;
    }

    sumPriceOri = model.sumPriceOrder!;

    sumTotalPrice();
  }

  void sumTotalPrice() {
    model.sumPriceOrderTotal = 0.00;
    double offerAmt = 0;

    // use rewardpoint
    rewardDiscout =
        (model.sumPriceOrder! * double.parse(model.rewardPerc!) / 100).ceil();
    if (rewardDiscout > model.rewardMaxPrice!)
      rewardDiscout = model.rewardMaxPrice!;

    if (!model.offerPercenStatus!) {
      //ไม่มีส่วนลด

      if (deliveryChargeSts)
        model.sumPriceOrderTotal =
            double.parse(model.sumPriceOrder!.toString()) +
                double.parse(modelDelical!.result!.deliveryCost.toString());

      model.offerAmount = Constants().priceDecimal(0);
    } else {
      //ข้อเสนอส่วนลด
      double _sumPriOrder = double.parse(model.sumPriceOrder.toString());
      double _offPerc = double.parse(model.offerPercentage.toString());
      double _offPercMin = double.parse(model.offerPercenMin.toString());
      double _offPercMax = double.parse(model.offerPercenMax.toString());

      if (_sumPriOrder >= _offPercMin) {
        // check min buying
        offerAmt = _sumPriOrder * _offPerc / 100;
        if (offerAmt > _offPercMax) offerAmt = _offPercMax; //check max offer
        sumPriceOri = _sumPriOrder - offerAmt;
      }

      model.offerAmount = Constants().priceFormat(offerAmt);

      model.sumPriceOrderTotal = model.sumPriceOrder! +
          modelDelical!.result!.deliveryCost! -
          double.parse(model.offerAmount!);
    }
    //ตรวจสอบว่ามีส่วนลดไหม
    if (discout > 0) {
      model.sumPriceOrderTotal =
          model.sumPriceOrderTotal! - double.parse(discout.toString());
    }

    //check reward
    double sumTotalBeforeCheckReward = model.sumPriceOrderTotal!;

    if (model.rewardOption.toString().toUpperCase() == 'YES' &&
        ((model.sumPriceOrderTotal! -
                double.parse(modelDelical!.result!.deliveryCost.toString())) >=
            double.parse(model.rewardMinBuy.toString())) &&
        rewardPoint >= int.parse(model.rewardPoint!)) {
      if (statusDiscountPoint)
        model.sumPriceOrderTotal =
            sumTotalBeforeCheckReward - rewardDiscout.toDouble();
    } else {
      model.sumPriceOrderTotal = sumTotalBeforeCheckReward;
      statusDiscountPoint = false;
    }

    placeOrderModel.orderSubTotal = model.sumPriceOrder.toString();
    placeOrderModel.ordertotalprice = model.sumPriceOrderTotal;

    notifyListeners();
  }

  void onSelectCoupon(
      {String? text, int? offerAmt, String? typeCoupon, int? index}) {
    clearVoucher();
    //check เวลาเปลี่ยนคูปองส่วนลด ต้อง reset ค่าที่เปลี่ยนไปกลับมา
    double _sumPriceOrder = sumPriceOri;
    modelDelical!.result!.deliveryCost = deliveryOri;

    //ปั้น model ส่งไป save
    placeOrderModel.voucherCode = text ?? '';
    placeOrderModel.voucherAmount = offerAmt ?? 0;
    voucherType = typeCoupon ?? '';

    if (typeCoupon == 'free_delivery') {
      modelDelical!.result!.deliveryCost = 0;
    } else if (typeCoupon == 'price') {
      _sumPriceOrder = _sumPriceOrder - offerAmt!;
      discout = offerAmt; // add discout

      if (model.sumPriceOrder! < 0) model.sumPriceOrder = 0;
    } else if (typeCoupon == 'percentage') {
      int _voucherValue =
          ((double.parse(voucherList![index!].offerValue.toString()) / 100) *
                  _sumPriceOrder)
              .toInt();
      if (_voucherValue > voucherList![index].maximumOrder!) {
        // checkMaxVoucher
        _sumPriceOrder = _sumPriceOrder - voucherList![index].maximumOrder!;
        discout = voucherList![index].maximumOrder!.toInt(); // add discout
      } else {
        _sumPriceOrder = model.sumPriceOrder! - _voucherValue;
        discout = _voucherValue; // add discout
      }
    }

    // ลบส่วนลดคูปอง
    model.sumPriceOrderTotal = _sumPriceOrder +
        double.parse(modelDelical!.result!.deliveryCost.toString());
    if (statusDiscountPoint)
      model.sumPriceOrderTotal =
          model.sumPriceOrderTotal! - rewardDiscout.toDouble();
    couponeCode = text!;
    placeOrderModel.paidFull = 'No';
    placeOrderModel.orderSubTotal = model.sumPriceOrder.toString();
    placeOrderModel.ordertotalprice = model.sumPriceOrderTotal;

    notifyListeners();
  }

  changeStatusDiscount(bool value) {
    statusDiscountPoint = value;
    sumOrderPrice();
    notifyListeners();
  }

  void clearVoucher() {
    voucherType = '';
    couponeCode = 'ใส่รหัสส่วนลด';
    discout = 0;
    placeOrderModel.voucherCode = '';
    placeOrderModel.voucherAmount = 0;
    placeOrderModel.paidFull = 'No';
  }

  void clearVoucherAndSumOrderPrice() {
    clearVoucher();
    sumOrderPrice();
  }

  void deleteOrder(int index) {
    listBasket.removeAt(index);
    if (listBasket.length == 0) {
      placeOrderModel.orderDescription = '';
      placeOrderModel.riderDescription = '';
    }
    clearVoucher();
    sumOrderPrice();
  }

  void removeOrder(int index) {
    if (listBasket[index].menuNum! > 1)
      listBasket[index].menuNum = listBasket[index].menuNum! - 1;

    clearVoucher();
    sumOrderPrice();
  }

  void addOrder(int index) {
    listBasket[index].menuNum = listBasket[index].menuNum! + 1;
    clearVoucher();
    sumOrderPrice();
  }

  void onchangeRemark(String remark, String flag) {
    if (flag == 'ร้านค้า') {
      placeOrderModel.orderDescription = remark;
    } else {
      placeOrderModel.riderDescription = remark;
    }
  }

  onChangerewardOffer(String text) {
    flagPage = text;
    notifyListeners();
  }

  setDeliveryChargeSts() {
    deliveryChargeSts = false;
    modelDelical = null;
  }

  checkInitPageby(String text) {
    flagPage = text;
    notifyListeners();
  }

  checkFailLocationPay(BuildContext context) {
    Constants().dialogProgress(context, pop: true);
    normalDialog(
        context, 'ที่อยู่การจัดส่งไม่อยู่ในพื้นที่ กรุณาเลือกที่อยู่จัดส่งใหม่',
        text: 'ปิด', onPressed: () {
      openbyCheckoutPageSts(true);
      checkStsSubmit(false);
      Navigator.popAndPushNamed(context, '/addressSelected');
    });
  }

  openbyCheckoutPageSts(bool status) {
    openByCheckoutPage = status;
    notifyListeners();
  }

  String checkDelivery() => modelDelical!.result!.deliveryCost == null
      ? ''
      : modelDelical!.result!.deliveryCost == 0
          ? 'Free'
          : modelDelical!.result!.deliveryCost.toString();

//-----------------------Select FoodDetail -------------------------------------//

  bool addOnSts = false;
  int groupValue = 0;
  int numOrder = 1;
  int sumNumOrderProd = 0;
  double sumPriceTotal = 0;
  int sumPriceShow = 0;
  String restId = '';
  String productDetailsID = '';
  int indexAddon = 1; //  start 1  เพราะทำไปก่อน 1 รอบ
  String creditCardAddToken = '';

  List<MenuList> listBasket = [];
  ProductDetailsModel? modelProduct;
  ProductDetails? data;
  ProductSubAddonModel? modelSubaddon;
  List<List<ProductAddons>> listSubAdddonList = [];
  List<ProductAddons>? listSubAdddon;

  String productID = '';

  intitdataProd(String proId) async {
    productID = proId; // set productID for use getSubAddOn
    numOrder = 1; // set ordernumver
    sumPriceShow = 0; //def sumshow order
    groupValue = 0;
    indexAddon = 1;
    addOnSts = false;
    listSubAdddonList = [];

    RestAPI().getData(
        url: ApiPath.productDetails,
        body: {"productId": productID}).then((value) {
      modelProduct = ProductDetailsModel.fromJson(value);
      data = modelProduct!.result!.productDetails;

      //set status radio
      for (var i = 0; i < data!.details!.menuDetails!.length; i++) {
        data!.details!.menuDetails![i].statuSelected = i;
      }
      //set default productDetailsID = first row menu becase groupValue = 0
      productDetailsID = data!.details!.menuDetails![groupValue].id.toString();
      sumPriceShow += data!.details!.menuDetails![groupValue].orginalPrice!;

      // set close opendetail addon
      data!.mainAddon!.forEach((element) {
        element.status = false;
      });

      //add addon all
      if (data!.mainAddon!.length == 0)
        addOnSts = true;
      else {
        //load addon
        getlistSubAddOn(data!.mainAddon!.first.mainaddonsId.toString());
      }

      notifyListeners();
    });
  }

  Future getlistSubAddOn(String mainAddonID) async {
    var body = {
      "productId": productID,
      "mainAddonId": mainAddonID,
      "productDetailId": productDetailsID
    };

    await RestAPI()
        .getData(url: ApiPath.productSubAddon, body: body)
        .then((value) {
      modelSubaddon = ProductSubAddonModel.fromJson(value);
      listSubAdddon = modelSubaddon!.result!.productAddons ?? [];
      listSubAdddonList.add(listSubAdddon!);
      //set defalse unselect

      //เช็ค addon ที่เพิ่มมาว่าเท่ากับกับตัว addonmain ไหม
      if (data!.mainAddon!.length == listSubAdddonList.length) {
        //clear check select
        for (var index = 0; index < listSubAdddonList.length; index++) {
          for (var i = 0; i < listSubAdddonList[index].length; i++) {
            listSubAdddonList[index][i].statusSelect = false;
          }
        }

        addOnSts = true;
      } else {
        getlistSubAddOn(data!.mainAddon![indexAddon].mainaddonsId.toString());
        indexAddon++;
      }

      notifyListeners();
    });
  }

  changeStatusOpenAddon(int index, bool sts) {
    //check index listaddon
    data!.mainAddon![index].status = sts;

    notifyListeners();
  }

  calnumOrder(String text) {
    // cal add and remove order
    if (text == 'add')
      numOrder++;
    else if (numOrder > 1) {
      numOrder--;
    }

    notifyListeners();
  }

  Future checkRest(String rest, BuildContext context) async {
    bool? _status;
    if (listBasket.length == 0) {
      _status = true;
      restId = rest;
      selectOrder();

      Navigator.pop(context);
    } else {
      if (restId == rest) {
        _status = true;
        selectOrder();

        Navigator.pop(context);
      } else {
        _status = false;
      }
      return _status;
    }
  }

  Future selectOrder() async {
    int priceMenuSelect = 0;
    int priceOriginal = 0;
    String detail = '';
    String addonName = '';
    int addonPrice = 0;
    String subName = '';

    data!.details!.menuDetails!.forEach((value) {
      if (value.statuSelected == groupValue) {
        //add priceOriginal (not + addon)
        priceOriginal = value.orginalPrice!;
        priceMenuSelect = value.orginalPrice!;

        subName = value.subName!;

        //add subnae in first Detail
        if (value.subName == data!.details!.menuName!)
          detail = '';
        else
          detail += value.subName!;
      }
    });

    //add menuDetail
    int indexadd = 0;

    if (data!.mainAddon!.length > 0 && addOnSts == true) {
      for (var index = 0; index < data!.mainAddon!.length; index++) {
        int countHeaderAddon = 0;
        listSubAdddonList[index].forEach((element) {
          if (element.statusSelect == true) {
            if (countHeaderAddon == 0) {
              detail += '\n${data!.mainAddon![index].mainaddonsName!} : ';
            }

            countHeaderAddon++;
            priceMenuSelect += element.subaddonsPrice!;
            addonPrice += element.subaddonsPrice!;
            detail +=
                '${element.subaddonsName!}[${element.subaddonsPrice! == 0 ? 'Free' : element.subaddonsPrice!}]';
            if (index == 0) {
              if (++indexadd != listSubAdddonList[index].length + 1) {
                addonName += ' + ';
                if (detail != '')
                  detail += ', '; //add , to text except lastindex
              }
            } else {
              addonName += ' + ';
              if (detail != '') detail += ', ';
            }

            addonName += '${element.subaddonsName!}';
          }
        });
      }
    }
    if (addonName != '') detail = detail.substring(0, detail.length - 2);

    bool _checkaddNumOrder = false;
    // เช็คออเดอร์ว่ามีการซื้อเมนูเดิมลงตะกร้าซ้ำไหม
    if (listBasket.length > 0) {
      listBasket.forEach((element) {
        if (element.menuDetail == detail &&
            element.menuHeader == data!.details!.menuName!) {
          element.menuNum = element.menuNum! + numOrder;
          _checkaddNumOrder = true;
        }
      });
      if (_checkaddNumOrder == false) {
        listBasket.add(new MenuList(
            menuDetail: detail,
            menuHeader: data!.details!.menuName!,
            menuNum: numOrder,
            menuPrice: priceMenuSelect,
            menuPriceOrginal: priceOriginal,
            menuSumPrice: priceMenuSelect * numOrder,
            menuType: data!.details!.menuType,
            addOnName: addonName,
            addonPrice: addonPrice,
            menuSize: subName,
            menuId: data!.details!.id!.toString()));
      }
    } else {
      //add list orderDetail for use in basketpage
      listBasket.add(new MenuList(
          menuDetail: detail,
          menuHeader: data!.details!.menuName!,
          menuNum: numOrder,
          menuPrice: priceMenuSelect,
          menuPriceOrginal: priceOriginal,
          menuSumPrice: priceMenuSelect * numOrder,
          menuType: data!.details!.menuType,
          addOnName: addonName,
          addonPrice: addonPrice,
          menuSize: subName,
          menuId: data!.details!.id!.toString()));
    }

    //add  sumNum and Sumorder use in Bottomsheet
    sumNumOrderProd += numOrder;
    sumPriceTotal += (priceMenuSelect * numOrder);

    notifyListeners();
  }

  void changeDataBottomSheet(int num, double pricetotal) {
    sumNumOrderProd = num;
    sumPriceTotal = pricetotal;

    notifyListeners();
  }

  void onSelectAddon(bool status, int indexmain, int index) {
    int _count = 0;

    //check addon ให้น้อยกว่าค่าที่ตั้งไว้
    if (status == true) {
      listSubAdddonList[indexmain].forEach((element) {
        if (element.statusSelect == true) _count++;
      });

      if (data!.mainAddon![indexmain].mainaddonsCount! > _count) {
        listSubAdddonList[indexmain][index].statusSelect = status;
        sumPriceShow += listSubAdddonList[indexmain][index].subaddonsPrice!;
      }
    } else {
      listSubAdddonList[indexmain][index].statusSelect = status;
      sumPriceShow -= listSubAdddonList[indexmain][index].subaddonsPrice!;
    }

    notifyListeners();
  }

  void clearBottomsheetAndEndTimeQrCode() {
    sumNumOrderProd = 0;
    sumPriceTotal = 0;
    listBasket.clear();
    //  endTime = 0; //--clear endtimtQrCode

    notifyListeners();
  }

  changeStatusSelectFood(int? status) {
    // clear price menu before
    sumPriceShow -= data!.details!.menuDetails![groupValue].orginalPrice!;

    // เลือก radio button อาหาร
    groupValue = status!;
    productDetailsID = data!.details!.menuDetails![groupValue].id.toString();

    // add price menu select
    sumPriceShow += data!.details!.menuDetails![groupValue].orginalPrice!;

    notifyListeners();
  }

  String minMaxaddonHeader(int min, int max) {
    String value = '';
    if (min == max)
      value = 'เลือกได้ : $max';
    else if (min == 0)
      value = 'เลือกได้ไม่เกิน : $max';
    else
      value = 'เลือกอย่างน้อย : $min สูงสุด : $max';
    return value;
  }

  bool checkStatusDiscountByReward() {
    if (model.rewardOption.toString().toUpperCase() == 'YES' &&
        ((model.sumPriceOrderTotal! -
                double.parse(modelDelical!.result!.deliveryCost.toString()) +
                statusDiscountPointCheck()) >=
            double.parse(model.rewardMinBuy.toString())) &&
        rewardPoint >= int.parse(model.rewardPoint!))
      return true;
    else
      return false;
  }

  double statusDiscountPointCheck() =>
      statusDiscountPoint ? rewardDiscout.toDouble() : 0.00;

  //-----------Payment GateWay----------------------------------------------

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber = creditCardModel!.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;

    notifyListeners();
  }

  resetCreditCard() {
    cardHolderName = '';
    cardNumber = '';
    expiryDate = '';
    cvvCode = '';

    notifyListeners();
  }

  onClickAddCreditCard(BuildContext context) async {
    //check number
    bool checkNumberinCardHolderName = true;
    cardHolderName.split('').forEach((value) {
      if (value == '0' ||
          value == '1' ||
          value == '2' ||
          value == '3' ||
          value == '4' ||
          value == '5' ||
          value == '6' ||
          value == '7' ||
          value == '8' ||
          value == '9') checkNumberinCardHolderName = false;
    });

    if (!checkNumberinCardHolderName) {
      normalDialog(context, 'ชื่อบัตรไม่สามารถเป็นตัวเลขได้', text: 'ปิด');
    } else {
      var preferences = await SharedPreferences.getInstance();
      List expiryDateSplit = expiryDate.split('/');
      List cardNumberSplit = cardNumber.split(' ');
      cardNumber = cardNumberSplit[0] +
          cardNumberSplit[1] +
          cardNumberSplit[2] +
          cardNumberSplit[3];

      try {
        //add key
        await RestAPI().getData(url: ApiPath.configs, body: {
          "key": omiseKey
        }).then((value) => omise = OmiseFlutter(value['result']['value']));

        final token = await omise!.token.create(cardHolderName, cardNumber,
            expiryDateSplit[0], expiryDateSplit[1], cvvCode,
            country: 'TH');

        creditCardAddToken = token.id.toString();

        await addCreditCard(creditCardAddToken);
        getListCreditCard(flage: 'addCredit');
        Navigator.pop(context);

        FirebaseLog().addLogDataToFirebase(
            actionBy: 'apiConfig omiseKey',
            body: '{"key": $omiseKey}',
            clientID: preferences.getString('id'),
            restData: '$creditCardAddToken');
      } catch (e) {
        print('\x1B[33m error credit $e\x1B[0m');
        normalDialog(context, 'ข้อมูลบัตรไม่ถูกต้อง !!', text: 'ปิด');

        FirebaseLog().addLogDataToFirebase(
            actionBy: 'apiConfig omiseKey',
            body: '{"key": $omiseKey}',
            clientID: preferences.getString('id'),
            restData: '$e');
      }
    }
  }

  onClickDeleteCreditCard(BuildContext context, int index) {
    normalDialog(context, 'ลบข้อมูล !',
        dialogYesNo: true,
        text: 'ตกลง',
        textSec: 'ยกเลิก', onPressed: () async {
      await deleteCreditCard(creditCardList![index].cardId.toString());
      getListCreditCard(flage: 'Delete');
      Navigator.pop(context);
    });
  }

  checkSelectPayType(String flag, {int? index}) {
    if (flag == 'cod') {
      placeOrderModel.paymentMethod = 'cod';
      creditCardList!.forEach((element) {
        element.statusSelect = false;
      });
      placeOrderModel.omiseCreditCardChoose = '';
      colorPromptpay = false;
      colorTrueMoneyWallet = false;
      colorMobileBanking = false;
      colorCod = true;
    } else if (flag == 'creditcard') {
      indexCreditCardSave = index!;
      placeOrderModel.paymentMethod = 'omise_credit_card';
      placeOrderModel.omiseCreditCardChoose =
          creditCardList![indexCreditCardSave].id.toString();

      creditCardList!.forEach((element) {
        element.statusSelect = false;
      });
      colorCod = false;
      colorPromptpay = false;
      colorTrueMoneyWallet = false;
      colorMobileBanking = false;
      creditCardList![index].statusSelect = true;
    } else if (flag == 'Promptpay') {
      placeOrderModel.paymentMethod = 'promptpay';
      creditCardList!.forEach((element) {
        element.statusSelect = false;
      });
      placeOrderModel.omiseCreditCardChoose = '';
      colorCod = false;
      colorTrueMoneyWallet = false;
      colorMobileBanking = false;
      colorPromptpay = true;
    } else if (flag == 'TrueMoneyWallet') {
      placeOrderModel.paymentMethod = 'truemoney_wallet';
      creditCardList!.forEach((element) {
        element.statusSelect = false;
      });
      placeOrderModel.omiseCreditCardChoose = '';
      colorCod = false;
      colorPromptpay = false;
      colorMobileBanking = false;
      colorTrueMoneyWallet = true;
    } else if (flag == 'MobileBanking') {
      placeOrderModel.paymentMethod = 'mobile_banking';
      creditCardList!.forEach((element) {
        element.statusSelect = false;
      });
      placeOrderModel.omiseCreditCardChoose = '';
      colorCod = false;
      colorPromptpay = false;
      colorTrueMoneyWallet = false;
      colorMobileBanking = true;
    }

    notifyListeners();
  }

  initialPaymentType() {
    if (model.rewardOption.toString().toUpperCase() != 'NO') {
      getPointSts = false;
      getReward();
    } else {
      getPointSts = true;
    }

    getListCreditCard();
  }

  bool colorPayType(String payType) {
    bool _status = false;
    if (payType == 'Promptpay')
      _status = colorPromptpay;
    else if (payType == 'MobileBanking')
      _status = colorMobileBanking;
    else if (payType == 'TrueMoneyWallet') _status = colorTrueMoneyWallet;
    return _status;
  }

  Future addCreditCard(String tokenId) async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "MyAccount",
      "page": "omiseAddCard",
      "omise_token_id": tokenId,
      "customer_id": preferences.getString('id')
    };
    try {
      await RestAPI().getData(url: ApiPath.omiseAddCard, body: body).then(
            (value) => FirebaseLog().addLogDataToFirebase(
                actionBy: 'addCreditCard',
                body: '$body',
                clientID: preferences.getString('id'),
                restData: '$value'),
          );
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'addCreditCard',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future deleteCreditCard(String cardid) async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "MyAccount",
      "page": "omiseDeleteCard",
      "cardid": cardid,
      "customer_id": preferences.getString('id')
    };
    try {
      await RestAPI().getData(url: ApiPath.omiseDeleteCard, body: body).then(
          (value) => FirebaseLog().addLogDataToFirebase(
              actionBy: 'deleteCreditCard',
              body: '$body',
              clientID: preferences.getString('id'),
              restData: '$value'));
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'deleteCreditCard',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future getListCreditCard({String? flage}) async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "action": "MyAccount",
      "page": "getOmiseCards",
      "customer_id": preferences.getString('id')
    };

    await RestAPI()
        .getData(url: ApiPath.getOmiseCards, body: body)
        .then((value) {
      creditCardListModel = CreditCardListModel.fromJson(value);
      creditCardList = creditCardListModel!.result!.cardDetails;
      if (creditCardList!.length > 0) {
        creditCardList!.forEach((element) {
          element.statusSelect = false;
        });

        if (flagPage == 'Delete') {
          //check Delete creditcard
          creditCardList![indexCreditCardSave - 1].statusSelect = true;
          placeOrderModel.omiseCreditCardChoose =
              creditCardList![indexCreditCardSave - 1].id.toString();
        } else if (flage == 'addCredit') {
          placeOrderModel.paymentMethod = 'omise_credit_card';
          colorCod = false;
          colorPromptpay = false;
          colorTrueMoneyWallet = false;
          colorMobileBanking = false;
          creditCardList!.forEach((element) {
            if (element.omiseTokenId == creditCardAddToken) {
              element.statusSelect = true;
              placeOrderModel.omiseCreditCardChoose = element.id.toString();
            }
          });
        } else if (placeOrderModel.paymentMethod == 'omise_credit_card') {
          placeOrderModel.omiseCreditCardChoose =
              creditCardList![indexCreditCardSave].id.toString();

          creditCardList![indexCreditCardSave].statusSelect = true;
        }
        notifyListeners();
      } else if (placeOrderModel.paymentMethod == 'omise_credit_card') {
        placeOrderModel.paymentMethod = 'cod';
        colorCod = true;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<bool> getPromptpayQrCode(BuildContext context) async {
    bool _checkStsLoading = true;
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "MyAccount",
      "page": "omiseCharges",
      "type": "promptpay",
      "amount": (placeOrderModel.ordertotalprice! * 100).toInt(),
      "customer_id": int.parse(preferences.getString('id').toString()),
      "order_id": orderIdResponse
    };
    try {
      await RestAPI()
          .getData(url: ApiPath.paymentOmise, body: body)
          .then((value) {
        promtPayQrCode = OmiseResponseModel.fromJson(value);
        _checkStsLoading = true;
        showQrCodeWebView(promtPayQrCode!
            .result!.charges!.source!.scannableCode!.image!.downloadUri!);

        FirebaseLog().addLogDataToFirebase(
            actionBy: 'PromptpayQrCode',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      _checkStsLoading = false;
      normalDialog(context, 'ระบบขัดข้องกรุณาลองใหม่อีกครั้ง', onPressed: () {
        isSubmit = false;
        notifyListeners();

        Navigator.popUntil(context, ModalRoute.withName('/payType'));
      });
      print('error getPromptpayQrCode $e');
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'PromptpayQrCode',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
    return _checkStsLoading;
  }

  Future showQrCodeWebView(String url) async {
    promptpayQrcodeUrl = '''<!DOCTYPE html>
    <html>
    <body>
    <div class="container">
        <section class="main_wrapper">
            <div class="aboutUsBg">     
                <div class="mt-30">
                    <div class="col-sm-10 col-sm-offset-1 col-xs-12 terms-area">
    					<img src="$url"/>
                    </div>
            </div>
        </section>
    </div>
    </body>
    </html>''';

    promptpayLoading = true;

    notifyListeners();
  }

  Future checkStsPromtPay(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "action": "MyAccount",
      "page": "getOmiseCharge",
      "charge": promtPayQrCode!.result!.charges!.id!,
      "customer_id": int.parse(preferences.getString('id').toString()),
    };

    try {
      RestAPI().getData(url: ApiPath.paymentOmise, body: body).then((value) {
        checkStatusPay = OmiseResponseModel.fromJson(value);
        timerDuration = Timer.periodic(Duration(seconds: 5), (_) async {
          if (checkStatusPay!.result!.charges!.status == 'successful') {
            if (isInForeground) {
              debugPrint('in app promtpay');
              timerDuration.cancel();

              Navigator.pushReplacementNamed(context, '/detailDelivery');

              clearDataMenuOrder(context);
              //orderExpire(true);

              Provider.of<DetailDeliveryProvider>(context, listen: false)
                  .getDataByOrderList(int.parse(orderIdResponse.toString()));
            } else {
              debugPrint('not in app');
              checkStsPromtPay(context);
            }
          } else if (checkStatusPay!.result!.charges!.status == 'failed') {
            isSuccessPPload = false;
            timerDuration.cancel();
            Navigator.pop(context);
          } else {
            if (promptpayLoading) checkStsPromtPay(context);
          }

          timerDuration.cancel();
        });
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'checkStsPromtPay',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'checkStsPromtPay',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
    notifyListeners();
  }

  timeoutPromptPay(BuildContext context) {
    timerDuration.cancel();
    isSubmit = false;
    promptpayLoading = false;
    isSuccessPPload = false;
    promptpayQrcodeUrl = '';

    screenshotBytes = null;
    orderExpire(false);
    notifyListeners();

    Navigator.pop(context);
  }

  successLoadingPromptpay() {
    isSuccessPPload = true;
    notifyListeners();
  }

  Future checkClosePromptPay(BuildContext context) async {
    normalDialog(context,
        'คุณต้องการยกเลิกการชำระเงินใช่หรือไม่ (กรณีชำระเงินแล้ว กรุณารอการประมวลผล)',
        text: 'ใช่', textSec: 'ไม่ใช่', dialogYesNo: true, onPressed: () async {
      Navigator.pop(context);
      Constants().dialogProgress(context);

      var preferences = await SharedPreferences.getInstance();

      var body = {
        "action": "MyAccount",
        "page": "getOmiseCharge",
        "charge": promtPayQrCode!.result!.charges!.id!,
        "customer_id": int.parse(preferences.getString('id').toString())
      };

      try {
        RestAPI().getData(url: ApiPath.paymentOmise, body: body).then((value) {
          checkStatusPay = OmiseResponseModel.fromJson(value);

          if (checkStatusPay!.result!.charges!.status == 'successful') {
            timerDuration.cancel();
            Navigator.pushReplacementNamed(context, '/detailDelivery');

            Provider.of<DetailDeliveryProvider>(context, listen: false)
                .getDataByOrderList(int.parse(orderIdResponse.toString()));

            clearDataMenuOrder(context);
          } else {
            Constants().dialogProgress(context, pop: true);
            timeoutPromptPay(context);
          }
        });
      } catch (e) {
        print('error check promptypay close  $e');
      }
      notifyListeners();
    });
  }

  Future checkStsLoadingMobileBanking(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "action": "MyAccount",
      "page": "getOmiseCharge",
      "charge": moblieBaking!.result!.charges!.id!,
      "customer_id": int.parse(preferences.getString('id').toString())
    };

    try {
      RestAPI().getData(url: ApiPath.paymentOmise, body: body).then((value) {
        checkStatusPay = OmiseResponseModel.fromJson(value);
        timerDuration = Timer.periodic(Duration(seconds: 3), (_) async {
          if (checkStatusPay!.result!.charges!.status == 'successful') {
            if (isInForeground) {
              timerDuration.cancel();
              clearDataMenuOrder(context);

              //   orderExpire(true);
              Navigator.pushReplacementNamed(context, '/detailDelivery');

              Provider.of<DetailDeliveryProvider>(context, listen: false)
                  .getDataByOrderList(int.parse(orderIdResponse.toString()));
            } else
              checkStsLoadingMobileBanking(context);
          } else if (checkStatusPay!.result!.charges!.status == 'failed') {
            timerDuration.cancel();

            clearDataMenuOrder(context);
            Navigator.pop(context);
          } else {
            checkStsLoadingMobileBanking(context);
          }

          timerDuration.cancel();
        });
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'checkStsLoading MobileBanking',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'checkStsLoading MobileBanking',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
    notifyListeners();
  }

  Future orderExpire(bool success) async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "MyAccount",
      "page": "OrderExpire",
      "order_id": orderIdResponse,
      "type": success,
      "customer_id": int.parse(preferences.getString('id').toString())
    };
    try {
      await RestAPI().getData(url: ApiPath.paymentOmise, body: body).then(
          (value) => FirebaseLog().addLogDataToFirebase(
              actionBy: 'orderExpire',
              body: '$body',
              clientID: preferences.getString('id'),
              restData: '$value'));
    } catch (e) {
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'orderExpire',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  timeoutAndCloseMoblieBanking(BuildContext context) {
    timerDuration.cancel();
    isSubmit = false;
    orderExpire(false);
    notifyListeners();

    Provider.of<DetailDeliveryProvider>(context, listen: false).stopLoading();

    Navigator.pop(context);
  }

  Future checkStsTrueMoneyWallet(int orderId) async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "action": "MyAccount",
      "page": "omiseCharges",
      "customer_id": int.parse(preferences.getString('id').toString()),
      "type": "truemoney",
      "amount": ordertotalprice,
      "phone_number": textFieldTrueMoney.text.toString(),
      "order_id": orderId
    };
    try {
      await RestAPI()
          .getData(url: ApiPath.paymentOmise, body: body)
          .then((value) {
        trueWallet = OmiseResponseModel.fromJson(value);

        trueWalletLoading = true;
        notifyListeners();
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'checkSts TrueMoneyWallet',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      print('\x1B[33m error $e\x1B[0m');
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'checkSts TrueMoneyWallet',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future checkStsMobileBanking(int orderId) async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "action": "MyAccount",
      "page": "omiseCharges",
      "customer_id": int.parse(preferences.getString('id').toString()),
      "type": bankingtypeSelect,
      "amount": (placeOrderModel.ordertotalprice! * 100).toInt(),
      "order_id": orderId
    };

    try {
      await RestAPI()
          .getData(url: ApiPath.paymentOmise, body: body)
          .then((value) {
        moblieBaking = OmiseResponseModel.fromJson(value);

        mobileBakingLoading = true;
        notifyListeners();
        print(moblieBaking!.result!.charges!.authorizeUri);
        FirebaseLog().addLogDataToFirebase(
            actionBy: 'checkSts MobileBanking',
            body: '$body',
            clientID: preferences.getString('id'),
            restData: '$value');
      });
    } catch (e) {
      print('\x1B[33m error bank $e\x1B[0m');
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'checkSts MobileBanking',
          body: '$body',
          clientID: preferences.getString('id'),
          restData: '$e');
    }
  }

  Future getListBanking() async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "action": "MyAccount",
      "page": "getListBanking",
      "customer_id": int.parse(preferences.getString('id').toString()),
    };
    try {
      RestAPI().getData(url: ApiPath.getListBanking, body: body).then((value) {
        listBanking = GetListBankingModel.fromJson(value);
        listBanking!.result!.banks!.forEach((element) {
          element.status = false;
        });
        listBanking!.result!.banks!.first.status = true;
        bankingtypeSelect = listBanking!.result!.banks!.first.source!;
        notifyListeners();
      });
    } catch (e) {
      print('\x1B[33m error listbank $e\x1B[0m');
    }
  }

  checkSelectBankType(int index) {
    listBanking!.result!.banks!.forEach((element) {
      element.status = false;
    });
    bankingtypeSelect = listBanking!.result!.banks![index].source!;
    listBanking!.result!.banks![index].status = true;
    notifyListeners();
  }

  submitMoblieBanking(BuildContext context) async {
    isSubmit = true;
    notifyListeners();

    await submitPlaceOrder(context);
    await checkStsMobileBanking(orderIdResponse);

    Navigator.pushNamed(context, '/mobileBankingLoading');
    checkStsLoadingMobileBanking(context);
    openSCBapp(moblieBaking!.result!.charges!.authorizeUri!);
  }

  submitPromptpayQrCode(BuildContext context) async {
    isSubmit = true;
    notifyListeners();

    await submitPlaceOrder(context); //step 1 วางออเดอร์
    if (await getPromptpayQrCode(
        context)) // step 2 get qrcode and charge id + check if case ติด catch
      await checkStsPromtPay(context); // check recursive promtpay
  }

  submitTrueMoneyWallet(BuildContext context) async {
    if (textFieldTrueMoney.text.toString().trim().length < 10)
      normalDialog(context, 'กรุณากรอกเลขให้ครบ 10 หลัก', text: 'ปิด');
    else if (textFieldTrueMoney.text.toString()[0] != '0')
      normalDialog(context, 'ตัวเลขตัวแรกต้องเป็น  0', text: 'ปิด');
    else {
      Navigator.pushNamed(context, '/trueMoneyWalletWebView');

      await submitPlaceOrder(context);
      await checkStsTrueMoneyWallet(orderIdResponse);
    }
  }

  Future onSuccessPayment(BuildContext context, String url) async {
    print('url truemoney');
    print(url);
    String _key = '';
    String _url = url
        .toString()
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')[0];

    try {
      await RestAPI().getData(url: ApiPath.configs, body: {
        "key": 'food_url'
      }).then((value) => _key = value['result']['value']);
    } catch (e) {
      debugPrint('print error food_url = $e');
    }
    _key = _key
        .toString()
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .replaceAll('/', '');

    if (_url == _key) {
      await Future.delayed(const Duration(milliseconds: 3000));
      updatePaymentSuccess(context);
    }
  }

  Future updatePaymentSuccess(BuildContext context) async {
    if (isInForeground) {
      timerDurationPayment.cancel();

      Navigator.pushReplacementNamed(context, '/detailDelivery');

      Provider.of<DetailDeliveryProvider>(context, listen: false)
          .getDataByOrderList(orderIdResponse);
      //reset ค่า
      clearDataMenuOrder(context);
      moblieBaking = null;
      mobileBakingLoading = false;
      trueWallet = null;
      trueWalletLoading = false;
      textFieldTrueMoney.text = '';
      notifyListeners();
    } else {
      timerDurationPayment = Timer.periodic(Duration(seconds: 2), (_) async {
        timerDurationPayment.cancel();
        notifyListeners();
        updatePaymentSuccess(context);
      });
    }
  }

  Future saveImageCapture(Uint8List image, BuildContext context) async {
    final result = await ImageGallerySaver.saveImage(image);
    debugPrint('show result = $result');

    normalDialog(context, 'บันทึกสำเร็จ');
  }

  takeSnapShort(Uint8List image) async {
    screenshotBytes = image;
    notifyListeners();
  }

  onCloseMoblieAndTrueWallet(BuildContext context) {
    timerDurationPayment.cancel();
    moblieBaking = null;
    mobileBakingLoading = false;
    trueWallet = null;
    trueWalletLoading = false;
    textFieldTrueMoney.text = '';

    Navigator.pop(context);
  }

  Future openSCBapp(String deepApp) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      if (Platform.isIOS) {
        // String url =
        //     'scbeasy://payments/bill/id/81e0bba6-def2-41be-b1f4-ca0e748b16c2';
        // ignore: deprecated_member_use
        if (await canLaunch(deepApp)) {
          // ignore: deprecated_member_use
          await launch(deepApp, forceSafariVC: false);
        } else {
          throw 'Could not launch $deepApp';
        }
      } else if (Platform.isAndroid) {
        ///checks if the app is installed on your mobile device
        bool isInstalled = await DeviceApps.isAppInstalled('com.scb.phone');
        if (isInstalled) {
          //open SCB and pay
          // ignore: deprecated_member_use
          launch(deepApp);
          isSubmit = false;
        } else {
          ///if the app is not installed it lunches google play store so you can install it from there
          // ignore: deprecated_member_use
          launch("market://details?id=" + "com.scb.phone");
          isSubmit = false;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

//---------------------------------------------------------------
