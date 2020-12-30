import 'package:flutter/cupertino.dart';

/// 项目配置
class Config {
  /// 当前环境
  // _Setting get env => dev;
  _Setting get env => produce;

  /// 初始页面
  String defaultPage = '/';

  // 背景颜色
  Color bgColor = Color(0xfff8f4f8);
  // 主色
  Color mainColor = Color(0xffF45858);

  /// 设计图尺寸-宽/高
  List<double> designSize = [750.0, 1334.0];

  /// token储存key
  String storageTokenKey = 'NETWORK_REQUEST_TOKEN';

  /// 开发调试
  _Setting get dev => _Setting(
        baseUrl: 'http://192.168.7.134:8013/api/mobile/app',
        // baseUrl: 'http://192.168.1.2:8013/api/mobile/app',
      );

  /// 线上生产
  _Setting get produce => _Setting(
        baseUrl: 'http://119.29.236.146:8013/api/mobile/app',
      );
}

class _Setting {
  String baseUrl;
  String uploadUrl;
  String socketIoUrl;

  _Setting({
    @required this.baseUrl,
    this.uploadUrl,
    this.socketIoUrl,
  });
}
