import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class JDNewSwiperPagination extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> lists = [];
    double size = 10 * 2;
    var margin = const EdgeInsets.symmetric(horizontal: 5.0);

    ScrollController scrollController = ScrollController();

    for (int i = 0; i < config.itemCount; i++) {
      lists.add(Container(
        margin: margin,
        width: size,
        height: size * 0.5,
        decoration: BoxDecoration(
            color: i == config.activeIndex ? Colors.black : Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(size * 0.5))),
      ));
    }

    final widget = Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        height: 2 * size,
        child: SingleChildScrollView(
          reverse: true,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: lists,
          ),
        ));

//延时滚动
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.positions.isEmpty) {
        return;
      }
      //组件宽度
      var parentWidth = (context.findRenderObject() as RenderBox).size.width;

      ///偏移计算单位
      final itemW = (margin.left + size + margin.right);

      ///一共占用多宽
      final totalWidth = (config.itemCount) * itemW;

      ///希望选中的item停留的位置
      final anchorPoint = 0.5 * parentWidth;

      ///当前选中的偏移量
      ///scrollview 使用了reverse
      var activeOffset =
          totalWidth - (config.activeIndex * itemW + 0.5 * itemW);
      if (activeOffset > anchorPoint) {
        final fixedOffset = activeOffset - anchorPoint;
        if (fixedOffset < totalWidth - parentWidth) {
          scrollController.animateTo(fixedOffset + 0.5 * itemW,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        } else {
          scrollController.animateTo(totalWidth - parentWidth,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      } else {
        if (scrollController.offset > activeOffset - 0.5 * itemW) {
          scrollController.animateTo(activeOffset - 0.5 * itemW,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      }
    });

    return widget;
  }
}
