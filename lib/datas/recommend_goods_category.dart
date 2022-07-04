import 'package:flutter/material.dart';

class RecommendGoodsCategory {
  final String title;
  final String subTitle;
  RecommendGoodsCategory({required this.title, required this.subTitle});

  static List<RecommendGoodsCategory> get debugCategories => [
        RecommendGoodsCategory(title: '精选', subTitle: '为你推荐'),
        RecommendGoodsCategory(title: '新品', subTitle: '新品速递'),
        RecommendGoodsCategory(title: '直播', subTitle: '主播力荐'),
        RecommendGoodsCategory(title: '实惠', subTitle: '便宜好货'),
        RecommendGoodsCategory(title: '进口', subTitle: '京东国际'),
      ];
}
