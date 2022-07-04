import 'package:flutter/material.dart';
import 'package:jd_demos/tools/value_range.dart';

class JdHomeSearchBar extends StatefulWidget {
  const JdHomeSearchBar({
    Key? key,
    this.scrollListener,
  }) : super(key: key);

  final ScrollController? scrollListener;

  @override
  State<JdHomeSearchBar> createState() => _JdHomeSearchBarState();
}

class _JdHomeSearchBarState extends State<JdHomeSearchBar> {
  final _iconRowHeight = 40.0;
  final _searchBarHeight = 30.0;

  ValueRange? _searchBarTopRange = null;
  late var _searchBarTop = _iconRowHeight;

  ValueRange? _totalHeightRange = null;
  double _totalHeight = 50;

  ValueRange? _searchBarEdgeMarginRange = null;
  var _searchBarEdgeMargin = 20.0;

  @override
  void initState() {
    super.initState();
    widget.scrollListener?.addListener(_handleScrollChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollListener?.dispose();
  }

  void _handleScrollChange() {
    var offset = widget.scrollListener?.offset;
    if (offset == null) {
      return;
    }
    final progress = (offset / _totalHeightRange!.max);
    if (progress >= 1.0) {
      _searchBarTop = _searchBarTopRange!.min;
      _totalHeight = _totalHeightRange!.min;
      _searchBarEdgeMargin = _searchBarEdgeMarginRange!.max;
    } else {
      final p = 1 - progress;
      _totalHeight = _totalHeightRange!.progressedValue(p);

      _searchBarTop = _searchBarTopRange!.progressedValue(p);

      ///加快searchbar的大小的修改进度
      _searchBarEdgeMargin =
          _searchBarEdgeMarginRange!.progressedValue(progress * 3.0);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaData = MediaQuery.of(context);

    _searchBarTopRange ??= ValueRange(min: 0, max: _iconRowHeight);
    if (_totalHeightRange == null) {
      _totalHeightRange = ValueRange(
          min: mediaData.padding.top + _iconRowHeight + 20,
          max: mediaData.padding.top + _iconRowHeight + _searchBarHeight + 20);
      _totalHeight = _totalHeightRange!.max;
    }

    _searchBarEdgeMarginRange ??= const ValueRange(min: 20.0, max: 100.0);

    return Container(
        color: Colors.red,
        height: _totalHeight,
        child: Padding(
          padding: EdgeInsets.only(top: mediaData.padding.top),
          child: Stack(
            children: [
              Positioned(
                  left: 20,
                  child: InkWell(
                    child: Icon(
                      Icons.account_tree_rounded,
                      color: Colors.white,
                    ),
                  )),
              Positioned(
                  right: 20,
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.add_home_work, color: Colors.white)
                    ],
                  )),
              Positioned(
                  top: _searchBarTop,
                  left: _searchBarEdgeMargin,
                  right: _searchBarEdgeMargin,
                  child: Container(
                    width: double.infinity,
                    height: _searchBarHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                  ))
            ],
          ),
        ));
  }
}
