//nada
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/homepage.dart';
import 'package:tarteeb_app/customes/customtextfield.dart';

class Rejister extends StatefulWidget {
  const Rejister({super.key});
  
  @override
  State<Rejister> createState() => _RejisterState();
}

class _RejisterState extends State<Rejister> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController collegecontroller=TextEditingController();
  TextEditingController departmentcontroller=TextEditingController();
  final GlobalKey<FormState> formkey=GlobalKey();
  String? password;
  bool iswomen=true;
  @override
  Widget build(BuildContext context) {
    double screenwidth =MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenwidth*0.1),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Text("Rejister here",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F41BB)
              ),
            ),
            Row(
              children: [
                Expanded(child: Lottie.asset('assets/welcome_intro.json')),
                Expanded(child: Lottie.asset('assets/book_walk.json'))
              ],
            ),
            SizedBox(
              height:20,
            ),
            CustomTextField(
              label: 'username', 
              keyboardType:TextInputType.text,
              picon: Icon(Icons.person),
              ocbscureText: false, 
              controller: usernamecontroller,
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
              onchange: (value){
                password=value;
              },
            ),
            SizedBox(
              height:20,
            ),
            CustomTextField(
              label: 'confirm password', 
              keyboardType:TextInputType.visiblePassword,
              picon: Icon(Icons.lock), 
              ocbscureText: true,
              controller: confirmpasswordcontroller,
              extraValidator: (value){
                if(password!=value){
                  return 'confirm password not the same password';
                }
                return null;
              },
            ),
            SizedBox(
              height:20,
            ),
            CustomTextField(
              label: 'College', 
              keyboardType:TextInputType.text, 
              controller: collegecontroller,
            ),
            SizedBox(
              height:20,
            ),
            CustomTextField(
              label: 'department', 
              keyboardType:TextInputType.text,
              controller: departmentcontroller,
            ),
            SizedBox(
              height:20,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title:Text('male') ,
                    value: false, 
                    groupValue: iswomen, 
                    onChanged: (val) {
                      setState(() {
                        iswomen = val!;
                      });
                    }
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('female'),
                    value: true, 
                    groupValue: iswomen, 
                    onChanged: (val) {
                      setState(() {
                        iswomen = val!;
                      });
                    }
                  ),
                )
              ],
            ),
            SizedBox(
              height:20,
            ),
            SizedBox(
              width: screenwidth*0.5 ,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor:Color(0xffFFD3B6),
                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(20) ,
                  ) ,
                ),
                onPressed: ()async{
                  if(formkey.currentState!.validate()){
                    formkey.currentState!.save();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(
                          username: usernamecontroller.text,
                          img: 'assets/Lemon Spring Shoot!  — Sarah driscoll.jpg', 
                          isFromLogin: false, 
                          iswomen: iswomen, 
                        ),
                      ),
                    );
                  }
                },
                child:Text("rejister",style: TextStyle(color: Color(0xff1E1B73)),) ,
              ),
            ) ,         
          ],
        ),
      ),
    );
  }
}