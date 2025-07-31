import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/intro/course.dart';
import 'package:tarteeb_app/Page%20content/intro/daystudy.dart';
import 'package:tarteeb_app/Page%20content/intro/introdialog.dart';
import 'package:tarteeb_app/Page%20content/intro/mood.dart';
import 'package:tarteeb_app/Page%20content/intro/satisfied.dart';
import 'package:tarteeb_app/Page%20content/intro/studyprofile.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/home.dart';
import 'package:tarteeb_app/Page%20content/study%20info/studypage.dart';
import 'package:tarteeb_app/tablet&phone%20design/custompage.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key, 
    required this.img, 
    required this.username, 
    required this.isFromLogin, 
    required this.iswomen
  });
  final String img;
  final String username;
  final bool isFromLogin;
  final bool iswomen;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late Widget currentDialogView;
 @override
  void initState() {
    super.initState();

    if (!widget.isFromLogin) {
      currentDialogView = Satisfied(
      onNext: () {
        setState(() {
          currentDialogView = Daystudy(
            onNext: () { 
              setState(() {
                currentDialogView = Studyprofile(
                  onNext: (int subjectCount) { 
                    setState(() {
                      currentDialogView = Courses(nocourse: subjectCount,);
                    });
                    Future.delayed(Duration.zero, () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Introdialog(introview: currentDialogView),
                      );
                    });
                  },
                );
              });
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Introdialog(introview: currentDialogView),
                );
              });
              },
            );
          });

          Future.delayed(Duration.zero, () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Introdialog(introview: currentDialogView),
            );
          });
        },
      );
    }
    else{
      currentDialogView=Mooddialog(onSelected:(String emoji) { 
          print("emoji selescted is$emoji");
        }, 
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Introdialog(introview: currentDialogView),
      );
    });
    
  }


  @override
  Widget build(BuildContext context) {
    double screenwidth =MediaQuery.of(context).size.width;
    return Custompage(
      appbarcontant:SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/tarteeb.png',fit: BoxFit.contain)
      ), 
      pagecontant:Home(iswomen:widget.iswomen) ,
      drawer: Drawer(
        width:screenwidth*0.4 ,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Studypage(), 
                  ),
                );
              }, 
              child: Text('study info')
            ),
            TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Studypage(), 
                  ),
                );
              }, 
              child: Text('personal info')
            ),
            TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Studypage(), 
                  ),
                );
              }, 
              child: Text('dark mode')
            ),
            TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Studypage(), 
                  ),
                );
              }, 
              child: Text('log out')
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomAppBar(
        color: Color(0xFFFFD3B6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.img),
            Text('Hello '),
            Text(widget.username)
          ],
        ),
      ) ,
    );
  }
}