import 'package:flutter/material.dart';
import 'package:tarteeb_app/tablet&phone%20design/appbar.dart';


class Custompage extends StatelessWidget {
  final Widget appbarcontant;
  final Widget pagecontant;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  const Custompage({
    super.key,
    required this.appbarcontant,
    required this.pagecontant,
    this.bottomNavigationBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = 150 + statusBarHeight;

    return Scaffold(
      body: Stack(
        children: [
          // AppBar background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: appBarHeight,
            child: CustomPaint(
              size: Size(double.infinity, appBarHeight),
              painter: AppBarPainter(),
            ),
          ),

          Positioned(
            top: statusBarHeight,
            left: 0,
            right: 0,
            child: appbarcontant,
          ),

          if (drawer != null)
            Positioned(
              top: statusBarHeight + 10,
              left: 10,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),

          // Page content
          Padding(
            padding: EdgeInsets.only(top: appBarHeight),
            child: pagecontant,
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }
}
