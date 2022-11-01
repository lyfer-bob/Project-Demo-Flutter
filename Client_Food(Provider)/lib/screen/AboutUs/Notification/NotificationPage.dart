import 'package:flutter/material.dart';
import 'package:/screen/AboutUs/Notification/AllNotic.dart';
import 'package:/screen/AboutUs/Notification/OrderNotic.dart';
import 'package:/screen/AboutUs/Notification/PromotionNoticPage.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  late AnimationController _animationControllerOn;
  late AnimationController _animationControllerOff;
  late Animation _colorTweenBackgroundOn;
  late Animation _colorTweenBackgroundOff;
  late Animation _colorTweenForegroundOn;
  late Animation _colorTweenForegroundOff;

  int _currentIndex = 0;
  int _prevControllerIndex = 0;
  double _aniValue = 0.0;
  double _prevAniValue = 0.0;
  List<String> categories = [
    "ทั้งหมด",
    "รายการคำสั่งซื้อ",
    "ข่าวสาร/โปรโมชั่น",
  ];

  // "ข่าวสาร/กิจกรรม",

  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.black;
  Color _backgroundOn = Colors.orangeAccent;
  ScrollController _scrollController = new ScrollController();
  List _keys = [];
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    Provider.of<GlobalURLProvider>(context, listen: false)
        .clearNoticModel()
        .then((value) {
      Provider.of<GlobalURLProvider>(context, listen: false)
          .noticListAPI()
          .then((value) {
        for (int index = 0; index < categories.length; index++) {
          _keys.add(new GlobalKey());
        }
        _controller = TabController(vsync: this, length: categories.length);
        _controller.animation!.addListener(_handleTabAnimation);
        _controller.addListener(_handleTabChange);
        _animationControllerOff = AnimationController(
            vsync: this, duration: Duration(milliseconds: 75));
        _animationControllerOff.value = 1.0;
        _colorTweenBackgroundOff =
            ColorTween(begin: _backgroundOn, end: _foregroundOn)
                .animate(_animationControllerOff);
        _colorTweenForegroundOff =
            ColorTween(begin: _foregroundOn, end: _foregroundOff)
                .animate(_animationControllerOff);

        _animationControllerOn = AnimationController(
            vsync: this, duration: Duration(milliseconds: 150));
        _animationControllerOn.value = 1.0;
        _colorTweenBackgroundOn =
            ColorTween(begin: _foregroundOn, end: _backgroundOn)
                .animate(_animationControllerOn);
        _colorTweenForegroundOn =
            ColorTween(begin: _foregroundOff, end: _foregroundOn)
                .animate(_animationControllerOn);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FragmentProvider>(
      builder: (context, pvd, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: pvd.currentIndex != 3 ? Colors.black : Colors.white),
                onPressed: () {
                  print('pvd.currentIndex::: ${pvd.currentIndex}');

                  if (pvd.currentIndex == 3)
                    pvd.changeIndexpage(pvd.currentIndex = 3);
                  else
                    pvd.changeIndexpage(pvd.currentIndex = 0);
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => Fragment()),
                  //     ModalRoute.withName('/'));
                  Navigator.popUntil(context, ModalRoute.withName('/fragment'));
                }),
            title: Text(
              'การแจ้งเตือน',
              style: TextStyle(color: _foregroundOff),
            ),
          ),
          backgroundColor: Colors.white,
          body: Consumer<FragmentProvider>(
            builder: (context, pvd, child) => !pvd.stsSigin
                ? Center(
                    child: Constants().fontStyleRegular(
                        'คุณยังไม่ได้ทำการ Login',
                        fontSize: 50,
                        colorValue: Color(0xFFCECECE)),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60.0,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      key: _keys[index],
                                      padding: EdgeInsets.all(10.0),
                                      child: ButtonTheme(
                                          child: AnimatedBuilder(
                                        animation: _colorTweenBackgroundOn,
                                        builder: (context, child) => Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _getBackgroundColor(index),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0),
                                            ),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                visualDensity: VisualDensity(
                                                    horizontal: 1),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _buttonTap = true;
                                                  _controller.animateTo(index);
                                                  _setCurrentIndex(index);
                                                  _scrollTo(index);
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                child: Text(
                                                  categories[index],
                                                  style: TextStyle(
                                                      color:
                                                          _getForegroundColor(
                                                              index)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )));
                                })),
                        Flexible(
                            child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            ShowAllNoticPage(),
                            OrderNoticPage(),
                            PromotionNoticPage(),
                            // NewsNoticPage(),
                          ],
                        )),
                      ]),
          )),
    );
  }

  _handleTabAnimation() {
    _aniValue = _controller.animation!.value;
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      _setCurrentIndex(_aniValue.round());
    }
    _prevAniValue = _aniValue;
  }

  _handleTabChange() {
    if (_buttonTap) _setCurrentIndex(_controller.index);
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      _triggerAnimation();
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    _animationControllerOn.reset();
    _animationControllerOff.reset();
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    double size = renderBox.size.width;
    double position = renderBox.localToGlobal(Offset.zero).dx;
    double offset = (position + size / 2) - screenWidth / 2;
    if (offset < 0) {
      renderBox = _keys[0].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      if (position > offset) offset = position;
    } else {
      renderBox =
          _keys[categories.length - 1].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      size = renderBox.size.width;

      if (position + size < screenWidth) screenWidth = position + size;

      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenBackgroundOff.value;
    } else {
      return _foregroundOn;
    }
  }

  _getForegroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }
}
