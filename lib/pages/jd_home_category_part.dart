import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/jd_home_goods.dart';
import '../widgets/jd_home_video_goods.dart';
import 'jd_home_page.dart';

///展示首页某一个顶部推荐分类的widget
class JdHomeCategoryPart extends StatefulWidget {
  final String name;
  JdHomeCategoryPart({Key? key, required this.name}) : super(key: key);

  @override
  State<JdHomeCategoryPart> createState() => _JdHomeCategoryPartState();
}

class _JdHomeCategoryPartState extends State<JdHomeCategoryPart> {
  @override
  void activate() {
    debugPrint('_JdHomeCategoryPartState active');
    super.activate();
  }

  @override
  void deactivate() {
    debugPrint('_JdHomeCategoryPartState deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_JdHomeCategoryPartState build');
    return Container(
      color: Colors.red,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
          color: Colors.grey[200],
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: Text(widget.name),
                  ),
                ),
                _buildCategorySliver(),
                _buildTwoAdSliver(),
                _buildBrandChoiceSliver(),
                _buildTop3SellSliver(),
                _buildCustomBtnsSliver(),
                _sectionTitleSliver(title: '京跳惠旋'),
              ];
            },
            body: _buildRecommondBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommondBody() {
    return MasonryGridView.count(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: 20,
        itemBuilder: (ctx, idx) {
          if (idx % 2 == 1) {
            return JdHomeVideoGoodsWidget(
              listContext: ctx,
            );
          }
          return const JdHomeNormalGoodsWidget();
        });
  }

  ///京跳惠旋
  Widget _sectionTitleSliver({required String title}) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  ///个性化需求五个按钮
  Widget _buildCustomBtnsSliver() {
    final customs = [
      '使用男装',
      '服装定制',
      '咱爸礼物',
      '大码男装',
      'G趋势男装',
    ];

    return _radiusRectWrapper(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Wrap(
            children: customs
                .map((e) => Container(
                      width: constraints.maxWidth / 5,
                      child: _ItemButton(img: '', name: e),
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  ///top 3
  Widget _buildTop3SellSliver() {
    Widget _getItem() {
      return Expanded(
          child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Text('热卖榜'),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.green[200],
                  height: 40.0,
                )
              ],
            )),
      ));
    }

    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          _getItem(),
          SizedBox(
            width: 5.0,
          ),
          _getItem(),
          SizedBox(
            width: 5.0,
          ),
          _getItem(),
        ],
      ),
    ));
  }

  ///品牌精选
  Widget _buildBrandChoiceSliver() {
    final brands = [
      '海澜之家',
      '森马',
      '皮尔卡丹',
      'Dickies',
      'Gap',
      '罗蒙',
      '吉普',
      '卡帝乐俄语'
    ];

    return _radiusRectWrapper(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '  品牌精选',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            LayoutBuilder(builder: ((context, constraints) {
              final children = brands
                  .map((e) => Container(
                        width: (constraints.maxWidth) / 4,
                        child: _ItemButton(img: '', name: e),
                      ))
                  .toList();
              return Wrap(
                runSpacing: 10.0,
                children: children,
              );
            }))
          ],
        ));
  }

  ///两个广告位
  Widget _buildTwoAdSliver() {
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
                child: AspectRatio(
                  aspectRatio: 2.2,
                  child: Container(
                    color: Colors.green[200],
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: ClipRRect(
                child: AspectRatio(
                  aspectRatio: 2.2,
                  child: Container(
                    color: Colors.green[200],
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
        ],
      ),
    ));
  }

  ///圆角矩形包装器
  Widget _radiusRectWrapper(
      {required Widget child,
      double radius = 12.0,
      EdgeInsets padding = EdgeInsets.zero}) {
    return SliverToBoxAdapter(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Container(
              padding: padding,
              color: Colors.white,
              child: child,
            )));
  }

  ///顶部分类
  Widget _buildCategorySliver() {
    final tabs = [
      '男装',
      '无性别T恤',
      '卫衣',
      '国潮推荐',
      'T恤',
      '运动裤',
      '条纹衬衫',
      '冰霜T恤',
      '工装裤',
      '商务休闲裤',
      '白色衬衫',
      '休闲短裤',
      '束脚裤',
      '西服',
      '更多'
    ];
    return _radiusRectWrapper(
        child: LayoutBuilder(builder: ((context, constraints) {
      final children = tabs
          .map((e) => Container(
                width: (constraints.maxWidth - 10.0) / 5,
                child: AspectRatio(
                  aspectRatio: 0.7,
                  child: _ItemButton(img: '', name: e),
                ),
              ))
          .toList();
      return Container(
        padding: EdgeInsets.all(5.0),
        child: Wrap(
          children: children,
        ),
      );
    })));
  }

  // @override
  // bool get wantKeepAlive => true;
}

class _ItemButton extends StatelessWidget {
  final String img;
  final String name;
  final VoidCallback? onTap;
  const _ItemButton(
      {Key? key, required this.img, required this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
