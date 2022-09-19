import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_demos/demo_common.dart';
import 'package:jd_demos/tools/globalkey_manager.dart';
import 'package:jd_demos/widgets/jd_home_tabbs.dart';
import 'package:jd_demos/widgets/jd_new_goods.dart';
import 'package:jd_demos/widgets/jd_new_swiper_pagination.dart';

class JDCarefullyChosePage extends StatefulWidget {
  final double topBarHeight;
  final void Function(double offset) topDidScroll;
  const JDCarefullyChosePage(
      {Key? key, required this.topBarHeight, required this.topDidScroll})
      : super(key: key);

  @override
  State<JDCarefullyChosePage> createState() => _JDCarefullyChosePageState();
}

class _JDCarefullyChosePageState extends State<JDCarefullyChosePage>
    with TickerProviderStateMixin {
  final GlobalKeyManager _km = GlobalKeyManager();

  var _tabsTop = 0.0;
  StateSetter? _tabStateSetter;
  final ScrollController _scrollController = ScrollController();

  // var _tabSelectedIdx = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateTabsLocation();
    });
    _scrollController.addListener(() {
      _updateTabsLocation();
      widget.topDidScroll(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabWidgets = [];
    for (int i = 0; i < 10; i++) {
      tabWidgets.add(const _TabsItemWidget(
        title: '商品分类',
        selected: false,
      ));
    }
    _tabController = TabController(length: tabWidgets.length, vsync: this);
    return Scaffold(
        body: Stack(
      children: [
        NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_buildSwiper(), _buildTabsPlaceHolder()];
          },
          body: _buildBody(),
        ),
        _buildTabbs(tabWidgets)
      ],
    ));
  }

  void _updateTabsLocation() {
    final key = _km.requestAndCache('tab-places-holder');
    final renderObject =
        key.currentContext?.findRenderObject() as RenderSliverToBoxAdapter;
    final parentData = renderObject.parentData as SliverPhysicalParentData?;
    final y = (parentData?.paintOffset.dy ?? 0.0 - _scrollController.offset);
    _tabsTop = max(widget.topBarHeight, y);
    if (_tabStateSetter != null) {
      _tabStateSetter!(() {});
    }
    ;
  }

  Widget _buildSwiper() {
    return SliverToBoxAdapter(
        child: Container(
      color: Colors.white,
      height: 300,
      child: Swiper(
        pagination: JDNewSwiperPagination(),
        itemCount: 5,
        itemBuilder: ((context, index) {
          return CachedNetworkImage(
            imageUrl: ImgUrls.girl,
            fit: BoxFit.cover,
          );
        }),
      ),
    ));
  }

  Widget _buildTabsPlaceHolder() {
    return SliverToBoxAdapter(
      key: _km.requestAndCache('tab-places-holder'),
      child: Container(
        height: 70,
      ),
    );
  }

  Widget _buildTabbs(List<Widget> tabWidgets) {
    return StatefulBuilder(builder: (context, setState) {
      _tabStateSetter = setState;
      return Positioned(
        top: _tabsTop,
        left: 0,
        right: 0,
        child: SizedBox(
          height: 70,
          child: JdHomeTabs(
            selectedIndex: _tabController.index,
            tabs: tabWidgets,
            onSelectCatetory: (idx) {
              _tabController.index = idx;
              if (_tabStateSetter != null) {
                _tabStateSetter!(() {});
              }
            },
            preSelectedWidgetGetter: (idx) {
              return tabWidgets[idx];
            },
            curSelectedWidgetGetter: (idx) {
              return const _TabsItemWidget(
                title: '商品分类',
                selected: true,
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildBody() {
    List<Widget> children = [];
    for (int i = 0; i < _tabController.length; i++) {
      children.add(MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 30),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: 20,
          itemBuilder: (ctx, idx) {
            if (idx % 2 == 1) {
              return JDNewGoods2Widget(
                imgUrl: ImgUrls.girl,
                goodsName: '梁红玉我的媳妇亲吻抚摸插屄舌吻扛起她的双腿',
                newAmountTxt: '8件上新',
                followAmountTxt: '2.5万人关注',
              );
            }
            return JDNewGoods1Widget(
              category: '新生活',
              imgUrl: ImgUrls.girl,
              name:
                  '梁红玉我的媳妇亲吻抚摸插屄舌吻扛起她的双腿梁红玉我的媳妇亲吻抚摸插屄舌吻扛起她的双腿梁红玉我的媳妇亲吻抚摸插屄舌吻扛起她的双腿',
              tags: ['梁红玉', '梁红玉', '梁红玉', '梁红玉'],
            );
          }));
    }
    return TabBarView(
      controller: _tabController,
      children: children as List<Widget>,
    );
  }
}

class _TabsItemWidget extends StatelessWidget {
  final String title;
  final bool selected;
  const _TabsItemWidget({Key? key, required this.title, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 5.0,
          child: Container(
            color: selected ? Colors.orange : Colors.transparent,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 40.0,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        )
      ],
    );
  }
}