import 'package:flutter/material.dart';

class JdHomeTabs extends StatefulWidget {
  const JdHomeTabs({
    Key? key,
    required this.tabs,
    required this.onTapCategory,
    required this.preSelectedWidgetGetter,
    required this.curSelectedWidgetGetter,
  }) : super(key: key);

  final List<Widget> tabs;
  final VoidCallback onTapCategory;
  final Widget Function(int index) preSelectedWidgetGetter;
  final Widget Function(int index) curSelectedWidgetGetter;

  @override
  State<JdHomeTabs> createState() => _JdHomeTabsState();
}

class _JdHomeTabsState extends State<JdHomeTabs> with TickerProviderStateMixin {
  late TabController _tabbController;

  int? _preSelectedIdx = null;
  int _curSelectedIdx = 0;

  @override
  void initState() {
    _tabbController = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, idx) {
                return GestureDetector(
                  onTap: () {
                    if (idx == _curSelectedIdx) {
                      return;
                    }
                    setState(() {
                      _preSelectedIdx = _curSelectedIdx;
                      _curSelectedIdx = idx;
                    });
                  },
                  child: _buildItem(idx),
                );
              },
              itemCount: widget.tabs.length,
            )),
            // Row(
            //   children: const [
            //     Icon(
            //       Icons.list,
            //       color: Colors.white,
            //     ),
            //     Text(
            //       '分类',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ],
            // )
          ],
        ));
  }

  Widget _buildItem(int index) {
    Widget item;
    if (index == _preSelectedIdx) {
      item = widget.preSelectedWidgetGetter(index);
    } else if (index == _curSelectedIdx) {
      item = widget.curSelectedWidgetGetter(index);
    } else {
      item = widget.tabs[index];
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 40,
      alignment: Alignment.center,
      child: item,
    );
  }
}
