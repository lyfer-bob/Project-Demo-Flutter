// import 'package:flutter/material.dart';
// import 'package:/screen/AboutUs/Notification/noticItem.dart';
// import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
// import 'package:/utils/Constants.dart';
// import 'package:provider/provider.dart';

// class NewsNoticPage extends StatefulWidget {
//   @override
//   _NewsNoticPageState createState() => _NewsNoticPageState();
// }

// class _NewsNoticPageState extends State<NewsNoticPage> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<GlobalURLProvider>(context, listen: false).noticListAPI();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GlobalURLProvider>(
//       builder: (BuildContext context, globalURLProviderValue, Widget? child) =>
//           Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: globalURLProviderValue.listNoticNEWS.isEmpty
//               ? Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Constants().fontStyleRegular('ไม่มีข้อมูล', fontSize: 18)
//                     ],
//                   ),
//                 )
//               : globalURLProviderValue.listNoticNEWS.length > 0
//                   ? CustomScrollView(
//                       slivers: [
//                         SliverList(
//                           delegate: SliverChildBuilderDelegate(
//                             (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 8),
//                                 child: noticItems(context,
//                                     index: index,
//                                     listdata:
//                                         globalURLProviderValue.listNoticNEWS),
//                               );
//                             },
//                             childCount:
//                                 globalURLProviderValue.listNoticNEWS.length,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     ),
//         ),
//       ),
//     );
//   }
// }
