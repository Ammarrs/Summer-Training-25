//nada
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/homepage.dart';
import 'package:tarteeb_app/customes/customtextfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  final GlobalKey<FormState> formkey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenwidth =MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenwidth*0.1),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Text("Login here",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F41BB)
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text("Welcome back you’ve \n been missed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(child: Lottie.asset('assets/book_walk.json')),
              ],
            ),
            SizedBox(
              height:20,
            ),
            CustomTextField(
              label: 'email', 
              keyboardType:TextInputType.emailAddress,
              picon: Icon(Icons.email),
              ocbscureText: false,
              controller: emailcontroller, 
            ),
            SizedBox(
              height:20,
            ),
            CustomTextField(
              label: 'password', 
              keyboardType:TextInputType.visiblePassword,
              picon: Icon(Icons.lock),
              ocbscureText: true, 
              controller: passwordcontroller,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: (){}, child: Text('forget your password?')),
            ),
            SizedBox(
              height:20,
            ),
            SizedBox( 
              width: screenwidth*0.5 ,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor:Color(0xffFFD3B6) ,
                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(20) ,
                  ) ,
                ),
                onPressed:()async{
                  if(formkey.currentState!.validate()){
                    formkey.currentState!.save();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(
                          username: emailcontroller.text, 
                          img: 'assets/Lemon Spring Shoot!  — Sarah driscoll.jpg', 
                          isFromLogin: true, 
                          iswomen: true, 
                        ),
                      ),
                    );
                  }
                },
                child:Text("login",style: TextStyle(color: Color(0xff1E1B73))) ,
              ),
            ),  
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(10)
                  ), 
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.facebook)
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.g_mobiledata)
                  ),
                ),
                 
              ],
            )  
          ]
        ),
      )
    );  
  }
}