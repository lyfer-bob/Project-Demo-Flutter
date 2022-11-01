import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class TrueMoneyWalletPage extends StatefulWidget {
  @override
  _TrueMoneyWalletPage createState() => _TrueMoneyWalletPage();
}

class _TrueMoneyWalletPage extends State<TrueMoneyWalletPage> {
  @override
  void initState() {
    Provider.of<BasketPageProvider>(context, listen: false)
        .checkStsSubmit(false, initPage: true); // checkSubmitSts

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Scaffold(
        appBar: AppBar(
          leading: constants.leadingBackIconAppBar(context),
          title: constants.fontStyleBold('การชำระเงิน', fontSize: 21),
          flexibleSpace: constants.flexibleSpaceInAppBar(),
        ),
        body: Consumer<BasketPageProvider>(
          builder: (context, pvd, child) => CustomScrollView(
            slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          constants.typeTabBar(context, 'TrueMoney Wallet',
                              fontSize: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Image.asset(
                                'assets/images/truemoney_wallet.png',
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Center(
                            child: constants.fontStyleBold(
                                'ชำระเงินผ่าน TrueMoney Wallet',
                                fontSize: 22,
                                colorValue: Colors.grey.shade400),
                          ),
                          Padding(
                            padding: Constants.paddingAppLRTB,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                constants.fontStyleBold('กรอกเบอร์โทรศัพท์',
                                    fontSize: 21,
                                    colorValue: Colors.grey.shade700),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 20),
                                  child: TextFormField(
                                    controller: pvd.textFieldTrueMoney,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFEBC18),
                                          width: 1.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                      ),

                                      hintText: 'เบอร์โทรศัพท์',
                                      hintStyle: Constants().textStyleRegular(
                                          colorValue: Color(0xFFC0C0C0)),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          10.0, 15.0, 20.0, 15.0),
                                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0F.0)),
                                    ),
                                  ),
                                ),
                                ButtonAccept(
                                  text: 'ยืนยันการชำระเงิน',
                                  backgroundColor: Color(0xFFFEBC18),
                                  fontColor: Colors.white,
                                  width: double.infinity,
                                  height: 50,
                                  fontSize: 21,
                                  fontStyleRegular: false,
                                  onPressed: () =>
                                      pvd.submitTrueMoneyWallet(context),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ))
            ],
          ),
        ));
  }
}
