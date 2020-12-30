import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:test1/utils/chewie_video.dart';

class TV extends StatefulWidget {
  final int movieId;
  TV(this.movieId);
  @override
  _TVState createState() => _TVState();
}

class _TVState extends State<TV> {
  Dio dio = Dio();
  String name;
  String playUrl;
  String imgUrl;
  String movieLabel;
  Map<String, dynamic> playList;
  @override
  void initState() {
    // _onLoad();
    super.initState();
  }

  Future<Response> _onLoad() async {
    String url2 =
        "https://api.eyunzhu.com/api/vatfs/resource_site_collect/getVDetail?vid=${widget.movieId}";
    final response = await dio.get(url2);
    Map<String, dynamic> mmm = response.data;
    Map<String, dynamic> data = mmm["data"];
    setState(() {
      name = data['name'];
      imgUrl = data['imgUrl'];
      movieLabel = data['label'];
      playList = data['playUrl'];
    });
    return response;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          name ?? '',
        ),
      ),
      body: Container(
        // height: 300,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: _player(),
            ),
            Container(
              child: _playlist(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playlist() {
    return FutureBuilder(
      future: _onLoad(),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        /*表示数据成功返回*/
        if (snapshot.hasData) {
          return Container(child: _playlistNode());
        } else {
          return GFLoader(type: GFLoaderType.ios);
        }
      },
    );
  }

  Widget _playlistNode() {
    var box = playList.keys
        .map(
          (e) => GFButton(
            onPressed: () {
              setState(() {
                playUrl = playList[e];
              });
            },
            text: e.toString(),
            type: GFButtonType.outline,
          ),
        )
        .toList();
    return Wrap(
      spacing: 2, //主轴上子控件的间距
      runSpacing: 5, //交叉轴上子控件之间的间距
      children: box, //要显示的子控件集合
    );
  }

  Widget _player() {
    if (playUrl != null) {
      return ChewieVideoWidget1(playUrl);
    } else {
      return Container(
        color: Color(0xFF000000),
      );
    }
  }
}
