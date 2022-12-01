import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jd_demos/models/new_model.dart';
import 'package:jd_demos/pages/jd_new_trend_page.dart';
import 'package:jd_demos/tools/globalkey_manager.dart';
import 'package:jd_demos/widgets/jd_new_follow_btn.dart';
import 'package:provider/provider.dart';

import 'jd_carefully_chosen_page.dart';

///新品页面
class JDNewPage extends StatefulWidget {
  const JDNewPage({Key? key}) : super(key: key);

  @override
  State<JDNewPage> createState() => _JDNewPageState();
}

class _JDNewPageState extends State<JDNewPage> {
  var _titles = ['DIOR', '精选', '趋势'];
  var _selectedIdx = 0;

  StateSetter? pageUpdateSetter;
  final GlobalKeyManager _km = GlobalKeyManager();
  var _topBarHeight = 0.0;

  StateSetter? _topBarStateSetter;
  var _topBgOpcity = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///更新坐标
      setState(() {
        _topBarHeight =
            _km.requestAndCache('top-bar').currentContext?.size?.height ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("<新品>被构建了");

    return ChangeNotifierProvider(
      create: (context) => NewGoodsModel(),
      builder: (context, child) {
        return Stack(
          children: [
            StatefulBuilder(builder: ((context, setState) {
              pageUpdateSetter = setState;
              return Stack(
                children: [
                  Offstage(
                      offstage: !(_selectedIdx == 0),
                      child: JDCarefullyChosePage(
                        topBarHeight: _topBarHeight,
                        topDidScroll: (offset) {
                          final pixels = max(min(offset, _topBarHeight), 0);
                          final opcaity = pixels / _topBarHeight;

                          _topBgOpcity = opcaity;
                          if (_topBarStateSetter != null) {
                            _topBarStateSetter!(() {});
                          }
                        },
                      )),
                  Offstage(
                    offstage: !(_selectedIdx == 1),
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Offstage(
                    offstage: !(_selectedIdx == 2),
                    child: const JDNewTrendPage(),
                  )
                ],
              );
            })),
            StatefulBuilder(builder: ((context, setState) {
              _topBarStateSetter = setState;
              return JDNewTopBar(
                key: _km.requestAndCache('top-bar'),
                middleTitles: _titles,
                bgOpacity: _topBgOpcity,
                onTapMiddleBtns: (idx) {
                  pageUpdateSetter!(() {
                    _selectedIdx = idx;
                  });
                },
                onTapMore: () {},
              );
            }))
          ],
        );
      },
    );
  }
}
