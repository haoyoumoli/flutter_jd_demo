import 'dart:ui';

import 'package:flutter/material.dart';

class _TitleAndSub extends StatelessWidget {
  final String title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  const _TitleAndSub(
      {Key? key,
      required this.title,
      this.subTitle,
      this.titleStyle,
      this.subTitleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> titles = [
      Text(
        title,
        style: titleStyle,
      ),
    ];
    if (this.subTitle != null) {
      titles.add(Text(
        subTitle!,
        style: subTitleStyle,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: titles,
    );
  }
}

class _AdItem0 extends StatelessWidget {
  const _AdItem0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //头部
        Row(
          children: [
            _TitleAndSub(title: '京东秒杀'),
            Container(
              color: Colors.red,
              width: 50,
              height: 10,
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildGoodsImgAndPrice(),
            ),
            SizedBox(
              width: 1.0,
            ),
            Expanded(child: _buildGoodsImgAndPrice())
          ],
        )
      ],
    );
  }

  Widget _buildGoodsImgAndPrice() {
    return Column(children: [
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          color: Colors.red,
        ),
      ),
      const Text.rich(TextSpan(
          text: '¥',
          style: TextStyle(fontSize: 10, color: Colors.red),
          children: [
            TextSpan(
                text: '298',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            TextSpan(
                text: '预估价', style: TextStyle(fontSize: 10, color: Colors.red))
          ]))
    ]);
  }
}

class _AdItem1 extends StatelessWidget {
  const _AdItem1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: _TitleAndSub(
            title: '京东秒杀',
            subTitle: '享更多折扣',
          ),
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}

class JdHomeAdsWidget extends StatelessWidget {
  const JdHomeAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _AdItem0()),
              SizedBox(
                width: 1.0,
              ),
              Expanded(child: _AdItem0())
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(child: _AdItem0()),
              SizedBox(
                width: 1.0,
              ),
              Expanded(child: _AdItem0())
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(child: _AdItem1()),
              SizedBox(
                width: 1.0,
              ),
              Expanded(child: _AdItem1()),
              SizedBox(
                width: 1.0,
              ),
              Expanded(child: _AdItem1()),
              SizedBox(
                width: 1.0,
              ),
              Expanded(child: _AdItem1())
            ],
          )
        ],
      ),
    );
  }
}
