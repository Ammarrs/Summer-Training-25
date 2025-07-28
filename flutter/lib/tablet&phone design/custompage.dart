//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/tablet&phone%20design/appbar.dart';

class Custompage extends StatefulWidget {
  final Widget appbarcontant;
  final Widget pagecontant;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  const Custompage({
    super.key, 
    required this.appbarcontant, 
    required this.pagecontant, 
    this.bottomNavigationBar, 
    this.drawer
  });
  @override
  State<Custompage> createState() => _CustompageState();
}

class _CustompageState extends State<Custompage> {
  
  @override
  Widget build(BuildContext context) {
    double screenhight =MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Stack(
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              children: [CustomPaint(
                size: Size(double.infinity,screenhight*0.35),
                painter: AppBarPainter(),
              ),
              Align(
              alignment: Alignment(-0.5,-1),
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 0.5,
                child: widget.appbarcontant,
              ),
              ),
              if (widget.drawer != null)
                Align(
                  alignment: Alignment(-0.95, -0.85), 
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 30),
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); 
                      },
                    ),
                  ),
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SingleChildScrollView(
            child: widget.pagecontant,
            ),
          )
        ],
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      drawer: widget.drawer,
    );
  }
}