import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jd_demos/demo_common.dart';
import 'package:video_player/video_player.dart';
import 'package:jd_demos/tools/extenstion.dart';

class JdHomeVideoGoodsWidget extends StatefulWidget {
  final ScrollEndNotification? scrollEndNotification;
  final BuildContext? listContext;
  JdHomeVideoGoodsWidget(
      {Key? key, this.scrollEndNotification, this.listContext})
      : super(key: key);

  @override
  State<JdHomeVideoGoodsWidget> createState() => _JdHomeVideoGoodsWidgetState();
}

class _JdHomeVideoGoodsWidgetState extends State<JdHomeVideoGoodsWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayController;

  bool _videoShouldPlay = false;

  @override
  void initState() {
    print('initState');
    super.initState();

    _videoPlayController = VideoPlayerController.network(VideoUrls.bee)
      ..initialize().then((value) {
        setState(() {});
      });
    _videoPlayController.setLooping(true);
  }

  @override
  void activate() {
    super.activate();
    //print('active');
  }

  @override
  void deactivate() {
    super.deactivate();
    //print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
     print('dispose');
    _videoPlayController.dispose();
  }

  void _hanldeShouldPlayVideo(BuildContext context) {
    //renderobject 不能是空,说明此时不是首次创建
    var renderObject = context.findRenderObject();
    if (renderObject == null || widget.scrollEndNotification == null) return;
    if (renderObject is! RenderBox) return;
    final offset = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;
    final screenMiddleY = MediaQuery.of(context).size.height * 0.5;
    if (offset.dy < screenMiddleY && offset.dy + size.height > screenMiddleY) {
      debugPrint('显示在屏幕中间');
      _videoShouldPlay = true;
    } else {
      _videoShouldPlay = false;
    }

    Future.delayed(Duration(milliseconds: 100), () {
      if (_videoShouldPlay) {
        debugPrint('播放${_videoPlayController.value.isPlaying}');
        _videoPlayController.play();
      } else {
        _videoPlayController.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${context.findRenderObject()?.attached}');
    _hanldeShouldPlayVideo(context);
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildVideoWidget(context),
              _buildNameWidget(context),
              _buildPublishInfoWidget(context)
            ],
          ),
        ));
  }

  Widget _buildVideoWidget(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Container(
        color: Colors.black,
        child: _videoPlayController.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _videoPlayController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayController),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildNameWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text.rich(
        TextSpan(children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  color: Colors.red),
              child: Text(
                '达人推荐',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          TextSpan(text: '海澜之家短袖T恤男2022圆领')
        ]),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPublishInfoWidget(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0, bottom: 2.0),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: CachedNetworkImage(
                  imageUrl: ImgUrls.girl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Text(
              '居家好品',
              overflow: TextOverflow.fade,
            )),
            Row(
              children: [Icon(Icons.watch_off), Text('8899')],
            ),
          ],
        ));
  }
}
