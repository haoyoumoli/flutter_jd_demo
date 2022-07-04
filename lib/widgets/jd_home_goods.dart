import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jd_demos/demo_common.dart';

class JdHomeNormalGoodsWidget extends StatelessWidget {
  const JdHomeNormalGoodsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Container(
        color: Colors.white,
        child: Stack(children: [
          //背景色

          Column(
            children: [
              AspectRatio(
                aspectRatio: 3.0 / 4.0,
                child: CachedNetworkImage(
                  imageUrl: ImgUrls.girl,
                  fit: BoxFit.cover,
                ),
              ),
              //商品名称
              _buildGoodsName(),
              _buildGoodsTags(),
              _buildPriceAndSmilar(),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
          //关闭按钮
          Positioned(
            right: 0.0,
            top: 0.0,
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              color: Colors.grey,
              iconSize: 15.0,
              icon: const Icon(Icons.close_rounded),
              onPressed: () {},
            ),
          ),
        ]),
      ),
    );
  }

  ///价格和看相似
  Widget _buildPriceAndSmilar() {
    return Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Row(
          children: [
            const Expanded(
                child: Text.rich(
              TextSpan(text: '¥', style: TextStyle(fontSize: 10), children: [
                TextSpan(
                    text: '449.',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                TextSpan(text: '00', style: TextStyle(fontSize: 10)),
              ]),
              style: TextStyle(color: Colors.red),
            )),

            ///看相似按钮
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: 20.0,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0))),
              child: const Text('看相似'),
            ),
          ],
        ));
  }

  Widget _buildGoodsName() {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: Text.rich(
          TextSpan(text: '', children: [
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                    margin: EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.red],
                            begin: FractionalOffset(0.0, 0.5),
                            end: FractionalOffset(1.0, 0.5))),
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Text(
                      '京东物流',
                      style: TextStyle(color: Colors.white),
                    ))),
            TextSpan(text: 'Air j ordan aj1 low 地磅男款 ')
          ]),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget _buildGoodsTags() {
    return Padding(
        padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
        child: Row(
          children: [
            Text(
              '自绘边框',
              style: TextStyle(
                  color: Colors.green,
                  background: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1.0
                    ..shader = LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.green, Colors.green])
                        .createShader(Rect.largest),
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.solid),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(2.0))),
              child: Text(
                '新品',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ));
  }
}
