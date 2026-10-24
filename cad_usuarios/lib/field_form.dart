import 'package:flutter/material.dart';

class FieldForm extends StatelessWidget {
  String label;
  bool isPassword;
  TextEditingController controller;
  bool? isForm = true;
  bool isEmail = true;
  
  FieldForm({
    required this.label,
    required this.isPassword,
    required this.controller, 
    this.isForm,
    required this.isEmail,
    super.key
       });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
      ),
      validator: (value){
        if(value!.length < 5){
          return "O campo deve ter no mínimo 5 caracteres";
        } 
        if (this.isEmail && !value.contains("@")){
          return "O campo deve ser um e-mail válido";
        }
      }
    );
  }
}