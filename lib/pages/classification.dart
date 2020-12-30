import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../setting/setting.dart';
import 'tv.dart';

class Classification extends StatefulWidget {
  @override
  _ClassificationState createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {
  Dio dio = new Dio();
  String searchKey;
  List movieData;
  int prePage = 50;
  int page = 1;
  List dioList;

  ///为Ture 则隐藏
  bool covertoast = true;

  String toasttext;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  ScrollController _controller = ScrollController();
  RefreshController loadNoData, loadFailed;

  @override
  void initState() {
    onload();
    super.initState();
  }

  void onload() {}

  void _onRefresh() async {
    // monitor network fetch
    int reqReCode;

    await Future.delayed(Duration(milliseconds: 1000), () async {
      var ret = await dio.get(
          'https://api.eyunzhu.com/api/vatfs/resource_site_collect/search',
          queryParameters: {'kw': searchKey, 'per_page': prePage, 'page': 1});
      Map<String, dynamic> rett = ret.data;
      Map<String, dynamic> rettt = rett['data'];

      reqReCode = rett['code'];
      dioList = rettt['data'];
    });
    if (reqReCode != 1) {
      _refreshController.refreshFailed();
      _gftoast(false, '加载错误！');
    }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    int reqLoadCode;
    await Future.delayed(Duration(milliseconds: 1000), () async {
      page = page + 1;
      var ret = await dio.get(
          'https://api.eyunzhu.com/api/vatfs/resource_site_collect/search',
          queryParameters: {
            'kw': searchKey,
            'per_page': prePage,
            'page': page
          });
      Map<String, dynamic> rett = ret.data;
      Map<String, dynamic> rettt = rett['data'];
      reqLoadCode = rett['code'];
      dioList = rettt['data'];
    });
    _gftoast(false, '没有更多内容');
    if (mounted)
      setState(() {
        toasttext = '加载错误！';
        covertoast = false;
      });
    if (reqLoadCode != 1) {
      _refreshController.loadFailed();
    } else {
      if (mounted)
        setState(() {
          if (dioList.length > 0) {
            movieData.addAll(dioList);
          } else {
            _refreshController.loadNoData();
            _gftoast(false, '没有更多内容');
          }
        });
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      backgroundColor: config.bgColor,
      appBar: _appsearchbar(),
      extendBody: true,
      // body: _gftoast(toasttext),
      body: Column(
        children: <Widget>[
          _gftoast(covertoast, toasttext),
          Expanded(child: _movieList(movieData))
        ],
      ),
    );
  }

  Widget _appsearchbar() {
    return GFAppBar(
      centerTitle: true,
      searchBar: true,
      title: Text("分类"),
      searchHintText: ('输入关键词'),
      onSubmitted: (val) async {
        page = searchKey == val ? page : 1;
        var ret = await dio.get(
            'https://api.eyunzhu.com/api/vatfs/resource_site_collect/search',
            queryParameters: {'kw': val, 'per_page': prePage, 'page': page});
        Map<String, dynamic> rett = ret.data;
        Map<String, dynamic> rettt = rett['data'];

        if (searchKey != val) {
          setState(() {
            searchKey = val;
            movieData = [];
          });
        }
        setState(() {
          searchKey = val;
          movieData = rettt['data'];
        });
        print(rettt['data'].length);
        if (rettt['data'].length > 0) {
          _controller.jumpTo(_controller.position.minScrollExtent);
        }
      },
    );
  }

  Widget _renderRow(BuildContext context, int i) {
    // if (movieData.length < i) {
    return GFBorder(
      color: Color(0xFF19CA4B),
      dashedLine: [1, 2],
      type: GFBorderType.rect,
      child: Container(
        child: GFListTile(
          onTap: () {
            print(movieData[i]['vid']);
            print(movieData[i]['pic']);
            int movieId = movieData[i]['vid'];
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TV(movieId)));
          },
          avatar: GFImageOverlay(
              height: 200,
              width: 150,
              image: NetworkImage(movieData[i]['pic'])),
          titleText: movieData[i]['name'],
          subtitleText: movieData[i]['type'],
          enabled: true,
        ),
      ),
    );
    // }
  }

  Widget _gftoast(bool covertoast, String toasttext) {
    return Offstage(
      offstage: covertoast,
      child: Center(
        child: GFToast(
          text: toasttext,
          autoDismiss: true,
        ),
      ),
    );
  }

  Widget _movieList(movieData) {
    if (movieData == null) {
      return Container(
        child: Offstage(
          offstage: covertoast,
          child: _gftoast(true, toasttext),
        ),
      );
    } else {
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("加载更多");
            } else {
              body = Text("没有内容");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          controller: _controller,
          itemBuilder: _renderRow,
          itemExtent: 200.0,
          itemCount: movieData.length,
        ),
      );
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
