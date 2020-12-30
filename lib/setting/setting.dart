/*
 * 插件初始化
 */

import '../utils/fit_size.dart';
import 'config.dart';
import 'routing.dart';

/// app应用配置
Config config = Config();

FitSize _size = FitSize(
  context: Routing.navigatorKey.currentContext,
  designWidth: config.designSize[0],
  designHeight: config.designSize[1],
  fontScaling: true,
);

/// 尺寸适配扩展
extension SizeExt on num {
  /// 长度适配
  double get w => _size.w(this);

  /// 长度适配
  double get h => _size.h(this);

  /// 长度适配
  double get f => _size.f(this);
}
