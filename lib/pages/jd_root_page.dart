import 'package:flutter/material.dart';
import 'package:jd_demos/pages/jd_cart_page.dart';
import 'package:jd_demos/pages/jd_home_page.dart';
import 'package:jd_demos/pages/jd_looking_page.dart';
import 'package:jd_demos/pages/jd_mine_page.dart';
import 'package:jd_demos/pages/jd_new_page.dart';

class JDRootPage extends StatefulWidget {
  const JDRootPage({Key? key}) : super(key: key);

  @override
  State<JDRootPage> createState() => _JDRootPageState();
}

class _JDRootPageState extends State<JDRootPage> {
  var _selectedIdx = 0;

  ///页面懒加载
  Widget? _homePage = null;
  Widget? _newPage = null;
  Widget? _lookingPage = null;
  Widget? _cartPage = null;
  Widget? _minePage = null;

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNaviItems = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "新品"),
      BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "逛"),
      BottomNavigationBarItem(
          icon: Icon(Icons.crop_rotate_rounded), label: "购物车"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
    ];

    return Scaffold(
        body: Stack(children: _getPages()),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          fixedColor: Colors.red,
          items: bottomNaviItems,
          currentIndex: _selectedIdx,
          onTap: (idx) {
            setState(() {
              _selectedIdx = idx;
            });
          },
        ));
  }

  List<Widget> _getPages() {
    return [
      _lazyLoadPage(
          childLoader: () {
            _homePage ??= const JdHomePage();
            return _homePage;
          },
          index: 0,
          holdedChild: _homePage),
      _lazyLoadPage(
          childLoader: () {
            _newPage ??= const JDNewPage();
            return _newPage;
          },
          index: 1,
          holdedChild: _newPage),
      _lazyLoadPage(
          childLoader: () {
            _lookingPage ??= const JDLookingPage();
            return _lookingPage;
          },
          index: 2,
          holdedChild: _lookingPage),
      _lazyLoadPage(
          childLoader: () {
            _cartPage ??= const JDCartPage();
            return _cartPage;
          },
          index: 3,
          holdedChild: _cartPage),
      _lazyLoadPage(
          childLoader: () {
            _minePage ??= const JDMinePage();
            return _minePage;
          },
          index: 4,
          holdedChild: _minePage),
    ];
  }

  Widget _lazyLoadPage(
      {required Widget? Function() childLoader,
      required int index,
      required Widget? holdedChild}) {
    bool display = _selectedIdx == index;
    return Offstage(
        offstage: !display,
        child: (holdedChild == null && display) ? childLoader() : holdedChild);
  }
}
