//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/zekra/zekradetails.dart';
import 'package:tarteeb_app/customes/customzekracard.dart';
// import 'package:tarteeb_app/customes/customzekracard.dart';

class Zekraview extends StatelessWidget {
  const Zekraview({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Customzekracard(isshared: false, iszekra:true , 
                imgpath:'assets/Children Photoshoot.jpg' , 
                title: 'my girl', 
                description: 'flower with my girl');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder:(context)=> Zekradetails()));
      },
      child: Icon(Icons.add),),
    );
  }
}