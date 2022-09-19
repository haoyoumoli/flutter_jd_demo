import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jd_demos/models/new_model.dart';
import 'package:provider/provider.dart';
import 'package:jd_demos/tools/globalkey_manager.dart';

class FollowStreamButton extends StatelessWidget {
  final Function() onTap;
  final Stream<bool> isFllowing;
  const FollowStreamButton(
      {Key? key, required this.isFllowing, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isFllowing,
      builder: (context, snapshot) {
        final boxDec = BoxDecoration(
            color: Colors.blue.shade500,
            borderRadius: const BorderRadius.all(Radius.circular(15.0)));
        Widget child;
        if (snapshot.hasData && (snapshot.data as bool) == true) {
          child = Container(
            alignment: AlignmentDirectional.center,
            height: 30.0,
            decoration: boxDec,
            child: const Text('已关注'),
          );
        } else {
          child = Container(
            alignment: AlignmentDirectional.center,
            height: 30,
            decoration: boxDec,
            child: Row(
              children: const [
                Icon(Icons.heart_broken_outlined),
                Text('关注'),
              ],
            ),
          );
        }

        return InkWell(
          onTap: onTap,
          child: child,
        );
      },
    );
  }
}

class FllowButton extends StatelessWidget {
  final Function() onTap;
  final bool isFllowing;
  const FllowButton({Key? key, required this.isFllowing, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
    final boxDec = BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)));
    Widget child;
    if (isFllowing) {
      child = Container(
        padding: padding,
        alignment: AlignmentDirectional.center,
        height: 30.0,
        decoration: boxDec,
        child: const Text('已关注'),
      );
    } else {
      child = Container(
        padding: padding,
        alignment: AlignmentDirectional.center,
        height: 30,
        decoration: boxDec,
        child: Row(
          children: const [
            Icon(Icons.heart_broken_outlined),
            Text('关注'),
          ],
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}

class _Cursor extends StatelessWidget {
  final double width;
  final double height;
  const _Cursor({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.5),
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.greenAccent],
          )),
    );
  }
}

class JDNewTopMidCategoriesButtons extends StatefulWidget {
  final List<String> titles;
  final void Function(int) onTap;
  final int startIdx;
  const JDNewTopMidCategoriesButtons(
      {Key? key,
      required this.titles,
      required this.onTap,
      required this.startIdx})
      : super(key: key);

  @override
  State<JDNewTopMidCategoriesButtons> createState() =>
      _JDNewTopMidCategoriesButtonsState();
}

class _JDNewTopMidCategoriesButtonsState
    extends State<JDNewTopMidCategoriesButtons> {
  final GlobalKeyManager _btnKeys = GlobalKeyManager();
  int _currentIdx = 0;
  Size? _cursorSize;
  Offset? _curOffset;
  @override
  void initState() {
    super.initState();
    _currentIdx = widget.startIdx;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateCursorPosition(_currentIdx);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = createButtons();
    const margin = 4.0;
    double cursorX = 0;
    double cursorY = 0;
    double cursorWidth = 0;
    double cursorHeight = 0;
    if (_curOffset != null) {
      cursorX = _curOffset!.dx + margin;
      cursorY = _curOffset!.dy + margin;
    }
    if (_cursorSize != null) {
      cursorWidth = _cursorSize!.width - 2 * margin;
      cursorHeight = _cursorSize!.height - 2 * margin;
    }

    return Container(
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(0, 0, 0, 0.4),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: cursorY,
              left: cursorX,
              child: _Cursor(
                width: cursorWidth,
                height: cursorHeight,
              )),
          Row(
            children: buttons,
          ),
        ],
      ),
    );
  }

  GlobalKey? _getCurBtnKey() {
    return _btnKeys.get(_currentIdx);
  }

  void _updateCursorPosition(idx) {
    setState(() {
      _currentIdx = idx;
      final ctx = _getCurBtnKey()?.currentContext;
      _cursorSize = ctx?.size;
      var parentData = ctx?.findRenderObject()?.parentData as FlexParentData?;
      _curOffset = parentData?.offset;
    });
  }

  List<Widget> createButtons() {
    List<Widget> buttons = [];
    List<String> titles = widget.titles;
    for (int i = 0; i < titles.length; i++) {
      GlobalKey key = _btnKeys.requestAndCache(i);

      buttons.add(TextButton(
          key: key,
          onPressed: () {
            _updateCursorPosition(i);
            widget.onTap(i);
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 70),
            child: Text(titles[i],
                maxLines: 1,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: i == _currentIdx ? Colors.black : Colors.white)),
          )));
    }
    return buttons;
  }
}

class JDNewTopBar extends StatelessWidget {
  final double bgOpacity;
  final void Function(int) onTapMiddleBtns;
  final void Function() onTapMore;
  final List<String> middleTitles;
  const JDNewTopBar(
      {Key? key,
      required this.middleTitles,
      required this.bgOpacity,
      required this.onTapMore,
      required this.onTapMiddleBtns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withOpacity(bgOpacity),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          children: [
            Selector<NewGoodsModel, bool>(
                builder: (context, isFllowing, child) {
                  return FllowButton(
                      isFllowing: isFllowing,
                      onTap: () {
                        final model = context.read<NewGoodsModel>();
                        model.isFollowing = !model.isFollowing;
                      });
                },
                selector: (p0, p1) => p1.isFollowing),
            JDNewTopMidCategoriesButtons(
              titles: middleTitles,
              startIdx: 0,
              onTap: onTapMiddleBtns,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more,
                  color: Colors.grey.shade300,
                ))
          ],
        ),
      )),
    );
  }
}
