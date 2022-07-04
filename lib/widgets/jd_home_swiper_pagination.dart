import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class JdHomeSwiperPaginationBuilder extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> lists = [];
    double size = 10;
    var margin = const EdgeInsets.symmetric(horizontal: 5.0);

    ScrollController scrollController = ScrollController();

    for (int i = 0; i < config.itemCount; i++) {
      if (i == config.activeIndex) {
        //当前索引pageindicator
        lists.add(Container(
          margin: margin,
          width: size * 2,
          height: size,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(size * 0.5))),
        ));
      } else {
        //其它pageindicator
        lists.add(Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size * 0.5))),
          margin: margin,
          width: size,
          height: size,
        ));
      }
    }
    //延时滚动
    Future.delayed(Duration(milliseconds: 100), () {
      //组件宽度
      var parentWidth = (context.findRenderObject() as RenderBox).size.width;

      ///偏移计算单位
      final itemW = (margin.left + size + margin.right);

      ///一共占用多宽
      final totalWidth = (config.itemCount) * itemW;

      ///希望选中的item停留的位置
      final anchorPoint = 0.5 * parentWidth;

      ///当前选中的偏移量
      var activeOffset = config.activeIndex * itemW;

      if (activeOffset > anchorPoint &&
          activeOffset < totalWidth - anchorPoint) {
        activeOffset = activeOffset - anchorPoint + itemW;
        scrollController.animateTo(activeOffset,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        //处理循环滚动的情况
        if (config.activeIndex == 0) {
          scrollController.jumpTo(0.0);
        } else if (config.activeIndex == config.itemCount - 1) {
          var offset = (totalWidth - parentWidth + size);
          scrollController.jumpTo(offset);
        }
      }
    });

    return Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        height: 2 * size,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: lists,
          ),
        ));
  }
}
