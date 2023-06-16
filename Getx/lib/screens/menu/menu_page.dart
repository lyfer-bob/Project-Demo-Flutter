import 'package:project/screens/package.dart';

class MenuPage extends GetView<MenuCController> {
  final ctrLogin = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: controller,
        initState: (_) {
          controller.init();
        },
        builder: (_) {
          return Scaffold(
              body: SingleChildScrollView(
            child: !ctrLogin.isLoadingLogin.value
                ? Center(child: CupertinoActivityIndicator(radius: 25))
                : (ctrLogin.errorLoading.value)
                    ? ErrorLoading()
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 50.0,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _headerRow(),
                            _imageAndDetails(),
                            TextApp(
                              text: 'Thanapol Thong-art',
                              fontSize: 16,
                            ),
                            TextApp(
                              text: 'เกือบ...',
                              fontSize: 16,
                            ),
                            _editProfile(context),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            Get.toNamed(SDBRoutes.story),
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Image.asset(
                                              'assets/images/art1.jpeg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextApp(
                                        text: "ArtWorks",
                                        fontSize: 13,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
          ));
        });
  }

  Row _editProfile(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 40,
              color: Colors.grey[300],
              child: Center(
                child: TextApp(
                  text: 'แก้ไขโปรไฟล์',
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 40,
                color: Colors.grey[300],
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.userPlus,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageAndDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(
                'assets/images/bobby.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Spacer(),
          _profileDetails('19', 'โพสต์'),
          Spacer(),
          _profileDetails('171', 'ผู้ติดตาม'),
          Spacer(),
          _profileDetails('302', 'กำลังติดตาม'),
          Spacer(),
        ],
      ),
    );
  }

  Column _profileDetails(String num, String detail) {
    return Column(
      children: [
        TextApp(
          text: '$num',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        TextApp(
          text: '$detail',
          fontSize: 15.5,
        ),
      ],
    );
  }

  Row _headerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextApp(
          text: 'bobby_lyfer',
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.squarePlus,
              color: Colors.black87,
              size: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.black87,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
