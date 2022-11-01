import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/Timer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MobileBankingLoading extends StatefulWidget {
  @override
  _MobileBankingLoading createState() => _MobileBankingLoading();
}

class _MobileBankingLoading extends State<MobileBankingLoading>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Provider.of<BasketPageProvider>(context, listen: false).isInForeground =
        state == AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
        builder: (context, pvd, child) => WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  title:
                      constants.fontStyleBold('Mobile Banking', fontSize: 25),
                  flexibleSpace: constants.flexibleSpaceInAppBar(),
                  automaticallyImplyLeading: false,
                  actions: [
                    Visibility(
                      visible: pvd.mobileBakingLoading,
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
                          child: InkWell(
                            onTap: () =>
                                pvd.timeoutAndCloseMoblieBanking(context),
                            child: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: pvd.mobileBakingLoading == false
                    ? constants.progressAPI()
                    : SingleChildScrollView(
                        child: Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                constants.fontStyleRegular('กรุณารอสักครู่..',
                                    fontSize: 40,
                                    colorValue: Colors.grey.shade400),
                                LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.amber,
                                  size: 200,
                                ),
                                Container(
                                  width: 60.0,
                                  padding:
                                      EdgeInsets.only(top: 3.0, right: 4.0),
                                  child: CountDownTimer(
                                    secondsRemaining: 300,
                                    whenTimeExpires: () => pvd
                                        .timeoutAndCloseMoblieBanking(context),
                                    countDownTimerStyle:
                                        constants.textStyleBold(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ));
  }
}
