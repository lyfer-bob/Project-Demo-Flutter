import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class MobileBankingPage extends StatefulWidget {
  @override
  _MobileBankingPage createState() => _MobileBankingPage();
}

class _MobileBankingPage extends State<MobileBankingPage> {
  @override
  void initState() {
    Provider.of<BasketPageProvider>(context, listen: false).getListBanking();
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
            builder: (context, pvd, child) => pvd.listBanking == null
                ? constants.progressAPI()
                : CustomScrollView(slivers: [
                    SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constants.typeTabBar(context, 'Mobile Banking',
                                  fontSize: 24),
                              Padding(
                                padding: Constants.paddingAppLRTB,
                                child: Column(
                                  children: [
                                    Column(children: [
                                      Column(
                                        children: List.generate(
                                          pvd.listBanking!.result!.banks!
                                              .length,
                                          (index) => Column(
                                            children: [
                                              listBanking(index),
                                              divider()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: ButtonAccept(
                                        text: 'ยืนยันการชำระเงิน',
                                        backgroundColor: pvd.isSubmit
                                            ? Colors.black12
                                            : Color(0xFFFEBC18),
                                        fontColor: Colors.white,
                                        width: double.infinity,
                                        height: 50,
                                        fontSize: 20,
                                        fontStyleRegular: false,
                                        onPressed: () => !pvd.isSubmit
                                            ? pvd.submitMoblieBanking(context)
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                  ])));
  }

  Widget listBanking(int index) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(pvdBasket.listBanking!.result!.banks![index].img!),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: constants.fontStyleBold(
                    pvdBasket.listBanking!.result!.banks![index].name!,
                    fontSize: 20,
                    colorValue: Colors.grey.shade800),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 4.0),
            child: InkWell(
              onTap: () => pvdBasket.checkSelectBankType(index),
              child: Icon(Icons.check_circle,
                  color: pvdBasket.listBanking!.result!.banks![index].status!
                      ? Color(0xFF40C057)
                      : Color(0xFFE4E4E4)),
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
      child: Divider(
        color: Color(0xFFE4E4E4),
        thickness: 1.5,
      ),
    );
  }
}
