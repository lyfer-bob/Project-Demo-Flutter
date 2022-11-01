import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrueMoneyWalletWebView extends StatefulWidget {
  @override
  _TrueMoneyWalletWebView createState() => _TrueMoneyWalletWebView();
}

class _TrueMoneyWalletWebView extends State<TrueMoneyWalletWebView>
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
    return Consumer2<BasketPageProvider, DetailDeliveryProvider>(
      builder: (context, pvd, pvdDeli, child) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: constants.fontStyleBold('TrueMoney Wallet', fontSize: 25),
              flexibleSpace: constants.flexibleSpaceInAppBar(),
              automaticallyImplyLeading: false,
              actions: [
                Consumer<BasketPageProvider>(
                  builder: (context, pvd, child) => Visibility(
                    visible: pvd.listBanking != null,
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
                          onTap: () => pvd.onCloseMoblieAndTrueWallet(context),
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: pvd.trueWalletLoading == false
                ? constants.progressAPI()
                : WebView(
                    gestureNavigationEnabled: true,
                    initialUrl: pvd.trueWallet!.result!.charges!.authorizeUri!,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (String url) =>
                        pvd.onSuccessPayment(context, url.toString()),
                    // onLoadStop: (controller, url) =>
                    //     pvd.onSuccessPayment(context, url.toString()),
                    // initialUrlRequest: URLRequest(
                    //     url: Uri.parse(
                    //         pvd.trueWallet!.result!.charges!.authorizeUri!)),
                    // onReceivedServerTrustAuthRequest:
                    //     (controller, challenge) async {
                    //   //Do some checks here to decide if CANCELS or PROCEEDS
                    //   return ServerTrustAuthResponse(
                    //       action: ServerTrustAuthResponseAction.PROCEED);
                    // },
                  )),
      ),
    );
  }
}
