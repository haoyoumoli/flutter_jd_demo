import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        color: Colors.grey.shade500,
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

class JDNewTopBar extends StatelessWidget {
  const JDNewTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          children: [
            FllowButton(isFllowing: false, onTap: () {}),
            const JDNewTopMidCategoriesButtons(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more,
                  color: Colors.white,
                ))
          ],
        ),
      )),
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
  const JDNewTopMidCategoriesButtons({Key? key}) : super(key: key);

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateCursorPosition(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = ['DIOR', '!!!精选!!!', '!趋势!'];
    List<Widget> buttons = [];
    for (int i = 0; i < titles.length; i++) {
      GlobalKey key = _btnKeys.requestAndCache(i);

      buttons.add(TextButton(
          key: key,
          onPressed: () {
            _updateCursorPosition(i);
          },
          child: Text(titles[i],
              style: TextStyle(
                  color: i == _currentIdx ? Colors.black : Colors.white))));
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
              top: _curOffset?.dy,
              left: _curOffset?.dx,
              child: _Cursor(
                width: _cursorSize?.width ?? 0,
                height: _cursorSize?.height ?? 0,
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
      debugPrint(_currentIdx.toString());
      debugPrint(_cursorSize.toString());
      debugPrint(_curOffset.toString());
    });
  }
}
