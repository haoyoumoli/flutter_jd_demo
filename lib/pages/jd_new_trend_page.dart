import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../demo_common.dart';
import '../widgets/jd_new_swiper_pagination.dart';

//新品趋势页面
class JDNewTrendPage extends StatefulWidget {
  const JDNewTrendPage({Key? key}) : super(key: key);

  @override
  State<JDNewTrendPage> createState() => _JDNewTrendPageState();
}

class _JDNewTrendPageState extends State<JDNewTrendPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // _buildSwiper(),
              SliverAppBar(
                  stretch: false,
                  pinned: true,
                  expandedHeight: 600,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: CachedNetworkImage(
                      imageUrl: ImgUrls.girl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize:
                        Size(MediaQuery.of(context).size.width, 48.0),
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [Text('页面一'), Text('页面二'), Text('页面三')],
                    ),
                  ))
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Container(
                child: Center(
                  child: Text('1'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('2'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('3'),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildSwiper() {
    return SliverToBoxAdapter(
        child: Container(
      color: Colors.white,
      height: 300,
      child: Swiper(
        pagination: JDNewSwiperPagination(),
        itemCount: 5,
        itemBuilder: ((context, index) {
          return CachedNetworkImage(
            imageUrl: ImgUrls.girl,
            fit: BoxFit.cover,
          );
        }),
      ),
    ));
  }
}
