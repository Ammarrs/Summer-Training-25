//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/notes&links/NotesLinks.dart';
import 'package:tarteeb_app/Page%20content/remind%20me%20up/Calender.dart';
import 'package:tarteeb_app/Page%20content/zekra/zekra.dart';
import 'package:tarteeb_app/customes/custombutton.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.iswomen});
  final bool iswomen;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
 
  
  @override
  Widget build(BuildContext context) {
    double screenwidth =MediaQuery.of(context).size.width;
    double screenheight =MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Custombutton(
                screenwidth: screenwidth, 
                text: 'chat bot', 
                lottie: widget.iswomen? 'assets/robbot_girl.json':'assets/robbot_boy.json', 
                screenheight: screenheight, onPressed: () {  },
              ),
              SizedBox(height: 20,),
              Custombutton(
                screenwidth: screenwidth, 
                text: 'zekra', 
                lottie: 'assets/zekra.json', 
                screenheight: screenheight, onPressed: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Zekraview()));
                },
              ),
              SizedBox(height: 20,),

              Custombutton(
                screenwidth: screenwidth, 
                text: 'remind me up', 
                lottie: 'assets/calendar.json', 
                screenheight: screenheight, onPressed: () { 
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarScreen()),
            );
                 },
              ),

              SizedBox(height: 20,),

              Custombutton(
                screenwidth: screenwidth, 
                text: 'notes&links', 
                lottie: 'assets/notes.json', 
                screenheight: screenheight, onPressed: () { 
                     Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotesLinks()),
            );
                 },
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}