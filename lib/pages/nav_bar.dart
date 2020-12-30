import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'classification.dart';
import 'index.dart';

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GFTabBarView(controller: tabController, children: <Widget>[
        Container(
          child: Index(),
        ),
        Container(
          child: Classification(),
        ),
        Container(
            // child: Player(),
            ),
        Container(
          alignment: Alignment.center,
          child: Container(
            child: new Text("789", style: TextStyle(fontSize: 20.0)),
          ),
          padding: const EdgeInsets.all(60.0),
          margin: const EdgeInsets.all(20.0),
          width: 180.0,
          height: 180.0,
        ),
      ]),
      bottomNavigationBar: GFTabBar(
        length: 4,
        controller: tabController,
        tabBarColor: Colors.green,
        tabs: [
          Tab(
            icon: Icon(Icons.home),
            child: const Text('主页'),
          ),
          Tab(
            icon: Icon(Icons.apps),
            child: const Text('分类'),
          ),
          Tab(
            icon: Icon(Icons.local_airport),
            child: const Text('起飞'),
          ),
          Tab(
            icon: Icon(Icons.person),
            child: const Text('个人'),
          ),
        ],
      ),
    );
  }
}
