import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class JdHomeSwiperTabs extends StatelessWidget {
  final List<JdHomeSwiperTabsItem> items;
  final void Function(int index)? onTap;

  const JdHomeSwiperTabs({Key? key, required this.items, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 5.0,
          children: items
              .map((e) => FractionallySizedBox(
                    widthFactor: constraints.maxWidth /
                        MediaQuery.of(context).size.width /
                        5.0,
                    child: _ItemButton(
                      item: e,
                    ),
                  ))
              .toList());
    });
  }

  static JdHomeSwiperTabs page1 = JdHomeSwiperTabs(
    items: [
      '京东国际',
      '京东拍卖',
      '京东生鲜',
      '沃尔玛',
      '京东旅行',
      '看病购药',
      '拍拍二手',
      '1号会员店',
      '种豆得豆',
      'PLUS会员'
    ].map((e) => JdHomeSwiperTabsItem(img: '', name: e)).toList(),
  );

}

@immutable
class JdHomeSwiperTabsItem {
  final String img;
  final String name;

  JdHomeSwiperTabsItem({required this.img, required this.name});
}

class _ItemButton extends StatelessWidget {
  final JdHomeSwiperTabsItem item;
  final VoidCallback? onTap;
  const _ItemButton({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            width: 50,
            height: 50,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(item.name)
        ],
      ),
    );
  }
}
