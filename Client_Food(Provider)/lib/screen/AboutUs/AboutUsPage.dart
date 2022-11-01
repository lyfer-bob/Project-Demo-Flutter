import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Constants().leadingBackIconAppBar(context),
          centerTitle: false,
          title: Constants().fontStyleBold('เกี่ยวกับเรา', fontSize: 21),
          flexibleSpace: Constants().flexibleSpaceInAppBar(),
        ),
        body: Container(
          child: Column(
            children: [
              logoEatHub(),
              Padding(
                padding: Constants.paddingAppLRTB,
                child: Constants().textAutoNewLine('เกี่ยวกับเรา',
                    colorValue: Colors.black, fontSize: 16),
              ),
              textDescription()
            ],
          ),
        ));
  }

  Widget logoEatHub() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo.jpg',
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          ),
          Icon(
            Icons.menu_rounded,
            color: Colors.amber,
          )
        ],
      ),
    );
  }

  Widget textDescription() {
    return Container(
      child: Column(
        children: [
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Constants().textAutoNewLine('บริษัท อี๊ดฮับ จำกัด (มหาชน)',
                colorValue: Colors.black, fontSize: 16),
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Constants().textAutoNewLine(
                '   ผู้ดำเนินธุรกิจการตลาดแบบตรง โดยการสื่อสารข้อมูลเพื่อเสนอขายสินค้าหรือบริการ โดยตรงต่อผู้บริโภค ผ่านช่องทางการตลาดหลากหลายช่องทาง (Multi-Channel Marketing) บริษัทฯ จดทะเบียนจัดตั้งขึ้นเมื่อวันที่ 21 เมษายน 2542 โดยมุ่งเน้นการสร้างประสบการณ์การช้อปปิ้งที่ลูกค้าสามารถสั่งซื้อสินค้าและบริการได้ทุกที่ทุกเวลา ด้วยสินค้าที่มีจำนวนกว่า 30,000 รายการ อาทิ สินค้าเพื่อสุขภาพ เครื่องใช้ภายในบ้าน ฟิตเนสและกีฬาอุปกรณ์ดูแลรถยนต์ อุปกรณ์เดินทาง สินค้ามงคลสินค้าแฟชั่น ความงาม และสินค้าใช้สำหรับเด็กเป็นต้น',
                colorValue: Colors.black,
                fontSize: 16),
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Constants().textAutoNewLine(
                '   โดยบริษัท อี๊ดฮับ จำกัด มีช่องทางการเสนอขายสินค้าและบริการผ่านช่องทางการสื่อสารหลากหลายช่องทาง เพื่อเข้าถึงผู้บริโภคโดยตรง อาทิ ช่องทางโทรทัศน์ ผ่านระบบโทรทัศน์ภาคปกติ (FreeTV) และโทรทัศน์ผ่านดาวเทียม ทั้ง C BAND และKU BAND ช่องทางแค็ตตาล็อค , ช่องทางออนไลน์ผ่านเว็บไซต์ tvdirect.tv,แอปพลิเคชั่นTVDirect และร้านค้าTVDirect มากกว่า 22 สาขาโดยมีจุดมุ่งหมายสูงสุดในการเป็นผู้นำการตลาดแบบตรงในประเทศไทย',
                colorValue: Colors.black,
                fontSize: 16),
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Constants().textAutoNewLine(
                '   xxxxxx.com เว็บไซต์เพื่อการเสนอขายสินค้าในระบบออนไลน์ (E-Commerce) ที่รวบรวมสินค้าหลากหลายรายการมาให้คุณเลือกมากมาย ด้วยวิธีการช้อบปิ้งที่สุดแสนจะสะดวกสบาย พร้อมขั้นตอนการชำระเงินที่ปลอดภัย นอกจากนี้ เว็บไซต์ทีวีไดเร็ค ยังได้มีการพัฒนาระบบใหม่เพื่อรองรับการใช้งานของผู้ใช้บนสมาร์ทโฟน เพื่อให้สามารถรองรับการใช้งานผู้บริโภคได้ตรงความต้องการมากที่สุด',
                colorValue: Colors.black,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
