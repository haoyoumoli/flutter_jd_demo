import 'package:flutter/material.dart';
import 'package:jd_demos/pages/jd_cart_page.dart';
import 'package:jd_demos/pages/jd_home_page.dart';
import 'package:jd_demos/pages/jd_looking_page.dart';
import 'package:jd_demos/pages/jd_mine_page.dart';
import 'package:jd_demos/pages/jd_new_page.dart';
import 'package:jd_demos/tools/lazy_build_offstage.dart';

class JDRootPage extends StatefulWidget {
  const JDRootPage({Key? key}) : super(key: key);

  @override
  State<JDRootPage> createState() => _JDRootPageState();
}

class _JDRootPageState extends State<JDRootPage> {
  var _selectedIdx = 0;

  ///页面懒加载
  Widget? _homePage;
  Widget? _newPage;
  Widget? _lookingPage;
  Widget? _cartPage;
  Widget? _minePage;

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
      LazyLoadOffstage(
          lazyLoader: () {
            _homePage ??= const JdHomePage();
            return _homePage;
          },
          needDisplayGetter: () {
            return 0 == _selectedIdx;
          },
          loadedChild: _homePage),
      LazyLoadOffstage(
          lazyLoader: () {
            _newPage ??= const JDNewPage();
            return _newPage;
          },
          needDisplayGetter: () {
            return 1 == _selectedIdx;
          },
          loadedChild: _newPage),
      LazyLoadOffstage(
          lazyLoader: () {
            _lookingPage ??= const JDLookingPage();
            return _lookingPage;
          },
          needDisplayGetter: () {
            return 2 == _selectedIdx;
          },
          loadedChild: _lookingPage),
      LazyLoadOffstage(
          lazyLoader: () {
            _cartPage ??= const JDCartPage();
            return _cartPage;
          },
          needDisplayGetter: () {
            return 3 == _selectedIdx;
          },
          loadedChild: _cartPage),
      LazyLoadOffstage(
          lazyLoader: () {
            _minePage ??= const JDMinePage();
            return _minePage;
          },
          needDisplayGetter: () {
            return 4 == _selectedIdx;
          },
          loadedChild: _minePage),
    ];
  }
}
