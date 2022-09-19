import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class JDNewGoods1Widget extends StatelessWidget {
  final String imgUrl;
  final String category;
  final String name;
  final List<String> tags;
  const JDNewGoods1Widget(
      {Key? key,
      required this.imgUrl,
      required this.category,
      required this.name,
      required this.tags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Stack(
          children: [
            Column(
              children: [
                CachedNetworkImage(
                  imageUrl: imgUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    name,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        maxWidth: constraints.maxWidth),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: tags.map((e) => _TagWidget(name: e)).toList(),
                    ),
                  );
                }),
                const SizedBox(height: 10),
              ],
            ),
            Positioned(
                top: 200 - 10,
                left: 10,
                child: _CategoryWidget(
                  name: category,
                ))
          ],
        ),
      ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  final String name;
  const _CategoryWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
              colors: [Colors.brown.shade50, Colors.brown],
              stops: [0.01, 1.0])),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _TagWidget extends StatelessWidget {
  final String name;

  const _TagWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Colors.brown[100]),
      child: Text(
        name,
        style: const TextStyle(color: Colors.brown),
      ),
    );
  }
}

///店铺商品推荐cell
class JDNewGoods2Widget extends StatelessWidget {
  final String imgUrl;
  final String goodsName;
  final String newAmountTxt;
  final String followAmountTxt;
  const JDNewGoods2Widget(
      {Key? key,
      required this.imgUrl,
      required this.goodsName,
      required this.newAmountTxt,
      required this.followAmountTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        color: Colors.amberAccent,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                children: [
                  Text(
                    goodsName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(color: Colors.brown, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '$newAmountTxt | $followAmountTxt ',
                    style: const TextStyle(color: Colors.brown, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const _GoShopBtn(),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _GoShopBtn extends StatelessWidget {
  const _GoShopBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      width: 100,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '进店逛逛',
            style: TextStyle(color: Colors.brown),
          ),
          Icon(
            Icons.fork_right,
            color: Colors.brown,
          )
        ],
      ),
    );
  }
}
