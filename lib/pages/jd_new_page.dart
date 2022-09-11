import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_demos/models/new_model.dart';
import 'package:jd_demos/widgets/jd_new_follow_btn.dart';
import 'package:provider/provider.dart';

///新品页面
class JDNewPage extends StatefulWidget {
  const JDNewPage({Key? key}) : super(key: key);

  @override
  State<JDNewPage> createState() => _JDNewPageState();
}

class _JDNewPageState extends State<JDNewPage> {
  final StreamController _followingSc = StreamController<bool>();

  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _followingSc.add(_isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("<新品>被构建了");
    return ChangeNotifierProvider(
      create: (context) => NewGoodsModel(),
      builder: (context, child) {
        return Stack(
          children: [
            Selector<NewGoodsModel, bool>(selector: (context, model) {
              return model.isFollowing;
            }, builder: ((context, isFollowing, child) {
              return Center(
                child: FittedBox(
                  child: FllowButton(
                      isFllowing: isFollowing,
                      onTap: () {
                        final model = context.read<NewGoodsModel>();
                        model.isFollowing = !model.isFollowing;
                        //修改isFollowing
                      }),
                ),
              );
            })),
            const JDNewTopBar(),
          ],
        );
      },
    );
  }
}
