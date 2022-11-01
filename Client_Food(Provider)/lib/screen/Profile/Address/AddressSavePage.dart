import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';

import 'AddressSavePageProvider.dart';

class AddressSavePage extends StatefulWidget {
  @override
  _AddressSavePageState createState() => _AddressSavePageState();
}

class _AddressSavePageState extends State<AddressSavePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddressSavePageProvider>(context, listen: false)
        .getAddress(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Constants().leadingBackIconAppBar(context),
          centerTitle: false,
          title: Constants().fontStyleBold('บันทึกที่อยู่', fontSize: 21),
          flexibleSpace: Constants().flexibleSpaceInAppBar(),
          actions: [
            Consumer<AddressSavePageProvider>(
              builder: (context, pvd, child) => Padding(
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
                    onTap: () => pvd.getActionPage(context, 'add'),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFFFEBC18),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Consumer<AddressSavePageProvider>(
          builder: (context, pvd, child) => Padding(
            padding: Constants.paddingAppLRTB,
            child: pvd.listAddress == null
                ? Constants().progressAPI()
                : pvd.listAddress!.length == 0
                    ? Text('')
                    : ListView.builder(
                        itemCount: pvd.listAddress!.length,
                        itemBuilder: _itemBuilder,
                      ),
          ),
        ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Consumer<AddressSavePageProvider>(
      builder: (context, pvd, child) => Padding(
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
                        Icon(pvd.listAddress![index].title == 'Home' ||
                                pvd.listAddress![index].title == 'บ้าน'
                            ? Icons.home
                            : pvd.listAddress![index].title == 'Office' ||
                                    pvd.listAddress![index].title == 'ออฟฟิศ'
                                ? IconImport.officeicon
                                : IconImport.location),
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
                          onPressedSec: () =>
                              pvd.getActionPage(context, 'edit', index: index)),
                      child: Icon(
                        Icons.linear_scale,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Constants().fontStyleBold(
                    'เลชที่ ${pvd.listAddress![index].flatNo} , ${pvd.listAddress![index].address}',
                    fontSize: 21,
                    colorValue: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
