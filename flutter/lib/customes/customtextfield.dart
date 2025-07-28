//nada
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, 
    required this.label, 
    required this.keyboardType, 
    this.onsaved, 
    this.picon,
    this.ocbscureText=false, 
    this.sicon, this.controller, 
    this.extraValidator, this.onchange,
  });
  final String label ;
  final TextInputType keyboardType;
  final void Function (String?)? onsaved;
  final Icon? picon;
  final bool ocbscureText;
  final Icon? sicon;
  final TextEditingController? controller;
  final String? Function(String?)? extraValidator;
  final void Function (String?)? onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onsaved,
      validator: (value) {
        if(value==null||value.isEmpty){
          return 'field is required';
        }
        if (extraValidator != null) {
          return extraValidator!(value);
        }
        return null;
      },
      onChanged: onchange,
      keyboardType: keyboardType,
      obscureText: ocbscureText,
      decoration:InputDecoration(
        suffixIcon: sicon,
        prefixIcon: picon,
        prefixIconColor: Color(0xff1E1B73),
        label:Text(label) ,
        labelStyle: TextStyle(
          color: Color(0xff1E1B73)
        )
      )
    );
  }
}