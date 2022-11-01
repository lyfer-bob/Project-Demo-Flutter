import 'package:flutter/material.dart';
import 'package:/screen/Profile/provider/AccumulatedPointsProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class AccumulatedPointsPage extends StatefulWidget {
  const AccumulatedPointsPage({Key? key}) : super(key: key);

  @override
  _AccumulatedPointsPageState createState() => _AccumulatedPointsPageState();
}

class _AccumulatedPointsPageState extends State<AccumulatedPointsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<AccumulatedPointsProvider>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Scaffold(
        appBar: AppBar(
          leading: Constants().leadingBackIconAppBar(context),
          centerTitle: false,
          title: Constants().fontStyleBold('คะแนนสะสม', fontSize: 21),
          flexibleSpace: Constants().flexibleSpaceInAppBar(),
        ),
        body: Center(
            child: Consumer<AccumulatedPointsProvider>(
          builder: (context, pvd, child) => pvd.model?.result?.success == 0 ||
                  pvd.model?.result?.customerPoints == null
              ? Constants().fontStyleBold('ไม่พบข้อมูล', fontSize: 21)
              : CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Center(
                              child: constants.fontStyleBold(
                                  'คะแนนคงเหลือ : ${pvd.model?.result?.totalPoints.toString()}',
                                  fontSize: 21,
                                  colorValue: Color(0xFF3D525C)),
                            ),
                          ),
                          Divider(
                            color: Color(0xFFFEBC18),
                            thickness: 2,
                          ),
                          Padding(
                            padding: Constants.paddingAppLRTB,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                pvd.listReward.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(1, 3),
                                          blurRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        firstRowDetail(index, context),
                                        // divider(),
                                        secondRowDetail(index),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        )));
  }

  Widget secondRowDetail(int index) {
    var constants = Constants();
    return Consumer<AccumulatedPointsProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Column(
          children: [
            rowDetail(
              constants.fontStyleRegular(pvd.listReward[index].type!,
                  colorValue: pvd.listReward[index].type == 'Spent'
                      ? Colors.red
                      : Color(0xFF40C057),
                  fontSize: 18),
              Row(
                children: [
                  constants.fontStyleRegular(
                      ' ${pvd.listReward[index].points} คะแนน',
                      fontSize: 18,
                      colorValue: Color(0xFF3D525C)),
                  pvd.listReward[index].order?.orderNumber == null
                      ? Text('')
                      : pvd.listReward[index].order!.rewardOffer == 0 ||
                              pvd.listReward[index].order!.rewardOffer == null
                          ? Text('')
                          : constants.fontStyleRegular(
                              ' (${constants.priceFormat(pvd.listReward[index].order!.rewardOffer)} ฿)',
                              fontSize: 18,
                              colorValue: Color(0xFF3D525C)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: FittedBox(
                      child: constants.fontStyleRegular(
                          pvd.listReward[index].restaurantName!,
                          fontSize: 18),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: constants.fontStyleRegular(
                        '${pvd.listReward[index].created!}',
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstRowDetail(int index, BuildContext context) {
    var constants = Constants();
    return Consumer<AccumulatedPointsProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
        child: rowDetail(
          pvd.listReward[index].order?.orderNumber == null
              ? constants.fontStyleRegular(
                  '${pvd.listReward[index].restaurantName.toString()}',
                  fontSize: 22)
              : constants.fontStyleRegular(
                  '${pvd.listReward[index].order?.orderNumber.toString()}',
                  fontSize: 22),
          pvd.listReward[index].order?.orderNumber == null
              ? constants.fontStyleRegular(
                  ' ${pvd.listReward[index].points} คะแนน',
                  fontSize: 22,
                  colorValue: Color(0xFF3D525C))
              : constants.fontStyleRegular(
                  '${pvd.listReward[index].total.toString()} ฿',
                  fontSize: 22,
                  colorValue: Color(0xFFFEBC18)),
        ),
      ),
    );
  }

  Widget rowDetail(Widget header, Widget value) {
    return Consumer<AccumulatedPointsProvider>(
      builder: (context, pvd, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [header, value],
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: Color(0xFFE4E4E4),
      thickness: 1,
    );
  }
}
