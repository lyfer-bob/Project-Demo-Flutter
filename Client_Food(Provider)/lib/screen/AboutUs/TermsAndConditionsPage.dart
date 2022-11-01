import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/SizeConfig.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: Constants().leadingBackIconAppBar(context),
          centerTitle: false,
          title: Constants().fontStyleBold('เงื่อนไขและข้อตกลง', fontSize: 21),
          flexibleSpace: Constants().flexibleSpaceInAppBar(),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                logoEatHub(),
                Padding(
                  padding: Constants.paddingAppLRTB,
                  child: Constants().textAutoNewLine('เงื่อนไขและข้อตกลง',
                      colorValue: Colors.black, fontSize: 16),
                ),
                textDescription()
              ],
            ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Constants().fontStyleBold(
              'นโยบายความเป็นส่วนตัวและความปลอดภัย',
              colorValue: Colors.black,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Constants().textAutoNewLine(
                ''
                'บริษัท ทีวี ไดเร็ค จำกัด (มหาชน) ได้คำนึงถึงความเป็นส่วนตัวและความปลอดภัยของผู้ใช้เป็นลำดับแรก ซึ่งข้อมูลส่วนบุคคลของผู้ใช้ที่ได้ลงทะเบียนผ่าน www.tvdirect.tv จะอยู่ภายใต้นโยบายนโยบายความเป็นส่วนตัวและความปลอดภัยของบริษัท ทีวี ไดเร็ค จำกัด (มหาชน) บริษัทฯ ตระหนักถึงความสำคัญของการคุ้มครองข้อมูลส่วนบุคคลในเครือข่ายอินเทอร์เน็ตเป็นอย่างยิ่ง',
                colorValue: Colors.black,
                fontSize: 16),
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Constants().textAutoNewLine(
                'ผู้ใช้สามารถเข้าเยี่ยมชมเว็บไซต์ของบริษัท ทีวี ไดเร็ค จำกัด (มหาชน) ได้ โดยมิต้องแจ้งให้บริษัททราบว่าท่านเป็นใคร รวมทั้งไม่ต้องเปิดเผยข้อมูลส่วนบุคคลต่างๆ ที่เกี่ยวกับผู้ใช้ เว็บเซิร์ฟเวอร์ของบริษัทจะบันทึกเพียงชื่อโดเมนเท่านั้น และจะไม่บันทึกที่อยู่อีเมลของผู้เข้าชมเว็บไซต์ ข้อมูลต่างๆ ที่ได้รับจะถูกนำการรวบรวมเพื่อนับจำนวนผู้เข้าเยี่ยมชม ระยะเวลาโดยเฉลี่ยของการเข้าชมเว็บไซต์ หรือการเข้าชมแต่ละหน้า เป็นต้น  เพื่อนำมาปรับปรุงเนื้อหาเว็บไซต์ของบริษัทต่อไป',
                colorValue: Colors.black,
                fontSize: 16),
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Constants().textAutoNewLine(
                'หากบริษัทฯ มีความประสงค์ที่จะจัดเก็บข้อมูลของผู้ใช้ เช่น ชื่อ และที่อยู่ บริษัทฯ จะแจ้งผู้ใช้ว่าเมื่อใดที่จะทำการจัดเก็บ วัตถุประสงค์ของการจัดเก็บข้อมูลส่วนบุคคลของผู้ใช้ โดยปกติแล้ว ข้อมูลที่บริษัทฯ จัดเก็บจะถูกใช้โดยบริษัทฯ เท่านั้น เพื่อใช้ในการตอบคำถาม หรืออนุญาตให้เข้าถึงข้อมูลที่มีลักษณะพิเศษได้ บางกรณี บริษัทฯ อาจเปิดเผยที่อยู่อีเมลของผู้ใช้ให้แก่เจ้าของผลิตภัณฑ์ หรือบริการ หากผู้ใช้มีความประสงค์ที่จะไม่เปิดเผยข้อมูลส่วนบุคคล สามารถแจ้งความประสงค์มายังบริษัทฯ ได้',
                colorValue: Colors.black,
                fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Constants().fontStyleBold(
              'เทคโนโลยี คุ๊กกี้ (Cookie)',
              colorValue: Colors.black,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: Constants.paddingAppLR,
            child: Constants().textAutoNewLine(
                'คุกกี้ คือ ข้อมูลส่วนหนึ่งที่เว็บไซต์จะส่งไปยังบราวเซอร์ของผู้ใช้ จากนั้น คุกกี้จะถูกนำไปเก็บไว้ในฮาร์ดดิสคอมพิวเตอร์ของผู้ใช้ ซึ่งจะทำให้บริษัทฯ ทราบว่าผู้ใช้ได้เข้ามาเยี่ยมชมเว็บไซต์ของบริษัทฯ โดยคุกกี้จะช่วยให้บริษัทฯ สามารถจัดการเกี่ยวกับสินค้าหรือบริการที่ผู้ใช้สนใจได้อย่างเหมาะสม นอกจากนี้อาจมีการนำข้อมูลมาประมวลผลเพื่อนำเสนอข้อมูลของสินค้าหรือบริการที่ตรงกับความต้องการของผู้ใช้ เพื่อให้ผู้ใช้สามารถเข้าเยี่ยมชมเว็บไซต์ได้อย่างสะดวกมากยิ่งขึ้น',
                colorValue: Colors.black,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
