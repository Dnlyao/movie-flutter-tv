import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:test1/pages/player.dart';

import '../setting/setting.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

// with AutomaticKeepAliveClientMixin
class _IndexState extends State<Index> {
  // @override
  // bool get wantKeepAlive => true;

  List<Map<String, dynamic>> listcard = [
    {
      'title': 'asd',
      'text': '叶问一打十',
      'url': 'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4',
    },
    {
      'title': 'CCTV1',
      'text': 'CCTV1',
      'url':
          'http://39.134.115.163:8080/PLTV/88888910/224/3221225618/index.m3u8',
    },
    {
      'title': '纬来',
      'url': 'http://59.120.242.104:9000/live/live11.m3u8',
      'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing'
    },
  ];

  final List<String> imageList = [
    'http://127.0.0.1/public/a1.jpg'
    // "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  void onLoad() {}

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      backgroundColor: config.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: config.bgColor,
        title: Text(
          '首页',
          style: TextStyle(
            fontSize: 34.0.f,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [_bannerNode(), _cardsNode()],
      ),
    );
  }

  /// 轮播图
  Widget _bannerNode() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),

        ///边框
        child: GFBorder(
          color: Color(0xFF19CA4B),
          dashedLine: [2, 0],
          type: GFBorderType.rect,
          child: Container(
            ///轮播图
            child: GFCarousel(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              items: imageList.map(
                (url) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (() => print(url)),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(url,
                            fit: BoxFit.cover, width: 1000.0),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ));
  }

  /// 卡片
  Widget _cardsNode() {
    var node = listcard
        .map(
          (it) => GFBorder(
            color: Color(0xFF19CA4B),
            dashedLine: [1, 2],
            type: GFBorderType.rect,
            child: Container(
              child: GFListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Player(
                        urlplay: it['url'],
                      ),
                    ),
                  );
                },
                avatar: GFImageOverlay(
                    height: 100,
                    width: 100,
                    image: AssetImage('public/a1.jpg')),
                titleText: it['title'],
                subtitleText: it['text'],
              ),
            ),
          ),
        )
        .toList();
    return Column(children: node);
  }
}
