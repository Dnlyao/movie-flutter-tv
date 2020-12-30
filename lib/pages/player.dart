import 'package:flutter/material.dart';

import '../setting/setting.dart';
import '../utils/chewie_video.dart';

class Player extends StatefulWidget {
  final String urlplay;
  Player({this.urlplay});

  @override
  _PlayerState createState() => _PlayerState();
}

// with AutomaticKeepAliveClientMixin
class _PlayerState extends State<Player> {
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
          '${widget.urlplay}',
          style: TextStyle(
            fontSize: 34.0.f,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(child: ChewieVideoWidget1(widget.urlplay)),
    );
  }
}
