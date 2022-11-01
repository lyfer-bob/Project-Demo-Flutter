import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/Timer.dart';
import 'package:provider/provider.dart';

class PromptpayQrCode extends StatefulWidget {
  @override
  _PromptpayQrCode createState() => _PromptpayQrCode();
}

class _PromptpayQrCode extends State<PromptpayQrCode>
    with WidgetsBindingObserver {
  InAppWebViewController? controller;
  Uint8List? screenshotBytes;

  GlobalKey globalKey = GlobalKey();

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
  Widget build(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => WillPopScope(
        onWillPop: () async => false,
        child: RepaintBoundary(
          key: globalKey,
          child: Scaffold(
            appBar: AppBar(
              title: constants.fontStyleBold('QR Code', fontSize: 25),
              flexibleSpace: constants.flexibleSpaceInAppBar(),
              automaticallyImplyLeading: false,
              actions: [
                Visibility(
                  visible: pvd.promptpayLoading,
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
                        onTap: () => pvd.checkClosePromptPay(context),
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
            body: pvd.promptpayLoading == false
                ? constants.progressAPI()
                : SingleChildScrollView(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: InAppWebView(
                            initialUrlRequest: URLRequest(
                                url: Uri.parse(
                                    'data:text/html;base64,${base64Encode(Utf8Encoder().convert(pvd.promptpayQrcodeUrl))}')),
                            onWebViewCreated:
                                (InAppWebViewController webViewController) {
                              controller = webViewController;
                            },
                            onLoadStop:
                                (InAppWebViewController controller, url) =>
                                    pvd.successLoadingPromptpay(),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Container(
                                width: 60.0,
                                padding: EdgeInsets.only(top: 3.0, right: 4.0),
                                child: CountDownTimer(
                                  secondsRemaining: 300,
                                  whenTimeExpires: () {
                                    pvd.timeoutPromptPay(context);
                                  },
                                  countDownTimerStyle:
                                      constants.textStyleBold(fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: downloadButton(),
          ),
        ),
      ),
    );
  }

  Widget downloadButton() {
    return Consumer<BasketPageProvider>(
        builder: (context, pvd, child) => Visibility(
              visible: pvd.isSuccessPPload,
              child: FloatingActionButton(
                onPressed: () async {
                  screenshotBytes = await controller!.takeScreenshot();
                  await pvd.takeSnapShort(screenshotBytes!);
                  await pvd.saveImageCapture(screenshotBytes!, context);
                },
                child: Icon(Icons.download),
              ),
            ));
  }
}
