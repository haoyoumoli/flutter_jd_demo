import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_demos/datas/recommend_goods_category.dart';
import 'package:jd_demos/widgets/jd_home_swipe_tab.dart';
import 'package:flutter/material.dart';
import 'package:jd_demos/widgets/jd_home_searchbar.dart';
import 'package:jd_demos/widgets/jd_home_swiper_pagination.dart';
import 'package:jd_demos/widgets/jd_home_tabbs.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:jd_demos/widgets/jd_home_video_goods.dart';
import 'dart:math' as math;

import '../widgets/jd_home_ads.dart';
import 'package:jd_demos/tools/extenstion.dart';
import 'package:jd_demos/demo_common.dart';

import '../widgets/jd_home_goods.dart';

class JdHomePage extends StatefulWidget {
  const JdHomePage({Key? key}) : super(key: key);

  @override
  State<JdHomePage> createState() => _JdHomePageState();
}

class _JdHomePageState extends State<JdHomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  final _tabbs = ['推荐', '运动', '手机', '视频', '生鲜', '男装'];

  final _goodsCategories = RecommendGoodsCategory.debugCategories;

  late AnimationController _animationController;
  late Animation<double> _animation;

  ///多订阅监听
  StreamController _animStreamController = StreamController<double>.broadcast();

  var _bottomTabsTopStreamController = StreamController<double>.broadcast();

  var _scrollDidStopStreamController =
      StreamController<ScrollEndNotification?>.broadcast();

  var _searchBarKey = GlobalKey();

  var _placeHolderKey = GlobalKey();

  double? _bttomTabsTopOffset;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween(begin: 0.0, end: 2 * math.pi).animate(_animationController)
          ..addListener(() {
            _animStreamController.add(_animationController.value);
          });

    ///nestedScrollView 滚动监听
    ///注意:这里不包括嵌套的MasonryGridView
    _scrollController.addListener(() {
      _changeGoodsCategoryWigetPosition();
      //_handleVideoPlayDuringScroll();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setInitialGoodsCategoryPosition();
    });
  }

  void _changeGoodsCategoryWigetPosition() {
    var cur = _bttomTabsTopOffset! - _scrollController.offset;

    ///悬停点
    cur = math.max(cur, _searchBarKey.currentContext!.size!.height);
    _bottomTabsTopStreamController.add(cur);
  }

  void _setInitialGoodsCategoryPosition() {
    var renderOBject = _placeHolderKey.getRenderObjectOfType<RenderSliver>();

    SliverPhysicalContainerParentData? parenData =
        typeAs(renderOBject?.parentData);
    if (parenData == null) return;

    if (_bttomTabsTopOffset == null) {
      _bttomTabsTopOffset = parenData.paintOffset.dy;
      _bottomTabsTopStreamController.add(_bttomTabsTopOffset!);
    }
  }

  ///在滚动结束时处理一些事件
  ///主要想要实现在滚动停止时,如果展示了视频商品,此时视频商品自动播放
  void _handleScrollEnd(ScrollEndNotification scrollEnd) {
    ///将滚动结束通知传递给视频播放widget;
    _scrollDidStopStreamController.add(scrollEnd);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _animStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // CustomScrollView(
        //   controller: _scrollController,
        //   slivers: [
        //     _buildTopSliverTabbs(context),
        //     _buildSwiper(),
        //     _buildSwiperTabButtons(),
        //     _buidSliverAdBox(),
        //     _buildRecommendGoodsTabbsSliverPlaceHolder(context),
        //     _buildSliverList(),
        //     _buildGoodsFlow(context)
        //   ],
        // ),

        //背景色
        Container(
          color: Colors.grey,
        ),
        NotificationListener<ScrollNotification>(
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return [
                    _buildTopSliverTabbs(context),
                    _buildClipWidget(),
                    _buildSwiper(),
                    _buildSwiperTabButtons(),
                    _buidSliverAdBox(),
                    _buildRecommendGoodsTabbsSliverPlaceHolder(context),
                    //_buildSliverList(),
                  ];
                }),
                body: MasonryGridView.count(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemCount: 20,
                    itemBuilder: (ctx, idx) {
                      if (idx % 2 == 1) {
                        return StreamBuilder(
                          stream: _scrollDidStopStreamController.stream,
                          builder: (_, snapshot) {
                            return JdHomeVideoGoodsWidget(
                              listContext: ctx,
                              scrollEndNotification:
                                  snapshot.data as ScrollEndNotification?,
                            );
                          },
                        );
                      }
                      return JdHomeNormalGoodsWidget();
                    })),
            onNotification: (ScrollNotification noti) {
              if (noti is ScrollEndNotification) {
                //debugPrint('${noti.metrics.pixels}');

                _handleScrollEnd(noti);
              }
              return true;
            }),
        //顶部搜索
        JdHomeSearchBar(
          key: _searchBarKey,
          scrollListener: _scrollController,
        ),
        _buildRecommnedGoodsTabbs(context)
      ],
    ));
  }

  ///底部推荐商品分类
  Widget _buildRecommnedGoodsTabbs(BuildContext context) {
    var tabWidgets = _goodsCategories
        .map(
          (e) => Column(
            children: [Text(e.title), Text(e.subTitle)],
          ),
        )
        .toList();

    return StreamBuilder<double>(
      initialData: -60.0,
      stream: _bottomTabsTopStreamController.stream,
      builder: (context, snapshot) {
        return Positioned(
            top: snapshot.data,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: JdHomeTabs(
                  tabs: tabWidgets,
                  onTapCategory: () {},
                  preSelectedWidgetGetter: (idx) {
                    _animationController.reset();
                    _animationController.forward();
                    // _animStreamController = StreamController<double>();
                    return StreamBuilder(
                      stream: _animStreamController.stream as Stream<double>,
                      initialData: 0.0,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Transform.rotate(
                          angle: snapshot.data!,
                          child: tabWidgets[idx],
                        );
                      },
                    );
                  },
                  curSelectedWidgetGetter: (idx) {
                    return Container(
                      width: 60,
                      color: Colors.green,
                    );
                  },
                ),
              ),
            ));
      },
    );
  }

  ///底部推荐商品分类占位,用于获取位置
  Widget _buildRecommendGoodsTabbsSliverPlaceHolder(BuildContext context) {
    return SliverToBoxAdapter(
      key: _placeHolderKey,
      child: Container(
        height: 60,
        // color: Colors.green,
        // child: const Text('我只是一个占位,为了使浮动的小黑块能和我对齐'),
        // alignment: Alignment.center,
      ),
    );
  }

  ///顶部分类tabbs
  Widget _buildTopSliverTabbs(BuildContext context) {
    var tabWidgets = _tabbs
        .map((e) => Text(
              e,
              style: TextStyle(color: Colors.white),
            ))
        .toList();

    return SliverToBoxAdapter(
        child: Container(
            color: Colors.red,
            height: MediaQuery.of(context).padding.top + 140,
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: JdHomeTabs(
                    tabs: tabWidgets,
                    onTapCategory: () {},
                    preSelectedWidgetGetter: (idx) {
                      _animationController.reset();
                      _animationController.forward();
                      _animStreamController = StreamController<double>();
                      return StreamBuilder(
                        stream: _animStreamController.stream as Stream<double>,
                        initialData: 0.0,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Transform.rotate(
                            angle: snapshot.data!,
                            child: tabWidgets[idx],
                          );
                        },
                      );
                    },
                    curSelectedWidgetGetter: (idx) {
                      return Container(
                        width: 60,
                        color: Colors.green,
                      );
                    },
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    Text(
                      '分类',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            )));
  }

  Widget _buildClipWidget() {
    return SliverToBoxAdapter(
      child: Container(
          height: 20,
          color: Colors.red,
          child: Container(
            height: 16,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
          )),
    );
  }

  Widget _buildSwiper() {
    return SliverToBoxAdapter(
        child: Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: 300,
      child: Swiper(
        // pagination: const SwiperPagination(
        //     builder: DotSwiperPaginationBuilder(
        //         activeColor: Colors.red, color: Colors.blue, size: 10)),
        pagination: JdHomeSwiperPaginationBuilder(),
        itemCount: 30,
        itemBuilder: ((context, index) {
          return Image.network(
            ImgUrls.girl,
            fit: BoxFit.fill,
          );
        }),
      ),
    ));
  }

  Widget _buildSwiperTabButtons() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Swiper(
          pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.red, color: Colors.blue, size: 10)),
          itemCount: 2,
          itemBuilder: (context, index) {
            return JdHomeSwiperTabs.page1;
          },
        ),
      ),
    );
  }

  Widget _buidSliverAdBox() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: JdHomeAdsWidget(),
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(_buildListItem, childCount: 50),
        itemExtent: 50);
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
        margin: const EdgeInsets.all(5),
        height: 50,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.red))),
        child: Text('item $index'));
  }
}
