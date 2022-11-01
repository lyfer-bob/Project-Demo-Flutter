import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';

class AddressSelected extends StatefulWidget {
  @override
  _AddressSelected createState() => _AddressSelected();
}

class _AddressSelected extends State<AddressSelected> {
  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Scaffold(
      appBar: AppBar(
        leading: constants.leadingBackIconAppBar(context),
        title: constants.fontStyleRegular('สถานที่จัดส่งอาหาร', fontSize: 21),
        flexibleSpace: constants.flexibleSpaceInAppBar(),
        actions: [
          Consumer<AddressSavePageProvider>(
            builder: (context, pvd, child) => Visibility(
              visible: pvd.listAddress == null ? false : true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 2.0, left: 4.0, top: 2.0, bottom: 2.0),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Consumer<AddressSavePageProvider>(
                    builder: (context, pvd, child) => InkWell(
                      onTap: () => pvd.getActionPage(context, 'add'),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFFFEBC18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Consumer3<AddressSavePageProvider, RestaurantMainProvider,
          BasketPageProvider>(
        builder: (context, pvd, pvdMain, pvdBasket, child) =>
            pvd.listAddress == null
                ? constants.progressAPI()
                : CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            Padding(
                              padding: Constants.paddingAppLRTB,
                              child: Column(
                                children: List.generate(
                                  pvd.listAddress!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: onClickSelectAddress(index, context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget onClickSelectAddress(int index, BuildContext context) {
    return Consumer3<AddressSavePageProvider, RestaurantMainProvider,
        BasketPageProvider>(
      builder: (context, pvd, pvdMain, pvdBasket, child) => InkWell(
        onTap: () async {
          dialogProgress(context);

          if ((pvdBasket.listBasket.length > 0 &&
              pvdBasket.model.paymentType!.length > 0)) {
            await pvd.getDataSearch(
                pvd.listAddress![index].latitude!,
                pvd.listAddress![index].longitude!,
                pvdBasket.model.latitudeRest!,
                pvdBasket.model.longitudeRest!);

            //check address ว่าอยู่ในขอบเขตของร้านอาหาร
            if (pvd.checkChangeAdress) {
              await pvd.selectAddress(index);
              await pvdBasket.onChangeAddressSubmit(
                  addressId: pvd.showAddress.id,
                  addressTitle: pvd.showAddress.title,
                  latitude: pvd.model!.result!.addressBook![index].latitude,
                  longtitude: pvd.model!.result!.addressBook![index].longitude,
                  context: context,
                  flag: 'ChangeForBuy');

              Navigator.pop(context);
              //get dellical
            } else {
              dialogProgress(context, pop: true);
              if (pvdBasket.openByCheckoutPage) {
                normalDialog(context,
                    'ที่อยู่การจัดส่งไม่อยู่ในพื้นที่ กรุณาเลือกที่อยู่จัดส่งใหม่',
                    text: 'ปิด');
              } else {
                normalDialog(
                  context,
                  'ที่อยู่การจัดส่งไม่อยู่ในพื้นที่ คุณต้องการเคลียร์ตะกร้าหรือไม่',
                  text: 'ตกลง',
                  textSec: 'ยกเลิก',
                  onPressed: () {
                    pvdBasket.clearDataMenuOrder(context);
                    Navigator.popUntil(
                        context, ModalRoute.withName('/fragment'));
                  },
                  dialogYesNo: true,
                );
              }
            }
          } else {
            await pvd.selectAddress(index);
            pvdMain.intitMainPage(flagPage: 'SelectAddress', context: context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            child: Padding(
              padding: Constants.paddingAppLRTB,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          showIcon(index),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Constants().fontStyleBold(
                                '${pvd.listAddress![index].title}',
                                fontSize: 21,
                                colorValue: Color(0xFF182024)),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => normalDialog(
                            context, 'คุณต้องการจะแก้ไขหรือลบข้อมูลใช่หรือไม่',
                            dialogYesNo: true,
                            text: 'ลบข้อมูล',
                            textSec: 'แก้ไขข้อมูล',
                            onPressed: () => pvd.deleteAction(context, index),
                            onPressedSec: () => pvd.getActionPage(
                                context, 'editByAddressSelected',
                                index: index)),
                        child: Icon(
                          Icons.linear_scale,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Constants().fontStyleBold(
                      'เลขที่ ${pvd.listAddress![index].flatNo} , ${pvd.listAddress![index].address}',
                      fontSize: 21,
                      colorValue: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showIcon(int index) {
    return Consumer<AddressSavePageProvider>(
      builder: (context, pvd, child) => Icon(
          pvd.listAddress![index].title == 'Home' ||
                  pvd.listAddress![index].title == 'บ้าน'
              ? Icons.home
              : pvd.listAddress![index].title == 'Office' ||
                      pvd.listAddress![index].title == 'ออฟฟิศ'
                  ? IconImport.officeicon
                  : IconImport.location),
    );
  }

  Future<Null> dialogProgress(BuildContext context, {bool pop = false}) async {
    pop
        ? Navigator.pop(context)
        : showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => SpinKitPouringHourGlass(
              color: Colors.amber,
              size: 100,
            ),
          );
  }
}
