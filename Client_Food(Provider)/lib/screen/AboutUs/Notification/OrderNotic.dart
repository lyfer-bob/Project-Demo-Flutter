import 'package:flutter/material.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/utils/Constants.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import 'noticItem.dart';

class OrderNoticPage extends StatefulWidget {
  @override
  _OrderNoticPageState createState() => _OrderNoticPageState();
}

class _OrderNoticPageState extends State<OrderNoticPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalURLProvider>(
      builder: (BuildContext context, globalURLProviderValue, Widget? child) =>
          Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: !globalURLProviderValue.loadingStsNotiOrder
              ? Constants().progressAPI()
              : globalURLProviderValue.listNoticOrder.length == 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Constants()
                              .fontStyleRegular('ไม่มีข้อมูล', fontSize: 30)
                        ],
                      ),
                    )
                  : globalURLProviderValue.listNoticOrder.length > 0
                      ? LazyLoadScrollView(
                          onEndOfPage: () {
                            if (globalURLProviderValue.loadingLazySuccess) {
                              globalURLProviderValue.noticListAPI(
                                  flag: 'Order');
                            }
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: noticItems(context,
                                          index: index,
                                          listdata: globalURLProviderValue
                                              .listNoticOrder,
                                          flagePage: 'Order'),
                                    );
                                  },
                                  childCount: globalURLProviderValue
                                      .listNoticOrder.length,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
        ),
      ),
    );
  }
}
