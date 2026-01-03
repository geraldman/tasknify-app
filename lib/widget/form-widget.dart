import 'package:flutter/material.dart';
import 'package:tasknify/styles/styles.dart';

class formDecorationOutlineFix extends StatefulWidget {
  final String textHint;
  final TextEditingController controller;

  const formDecorationOutlineFix({
    super.key,
    required this.textHint,
    required this.controller
  });

  @override
  State<formDecorationOutlineFix> createState() => _formDecorationOutlineFixState();
}

class _formDecorationOutlineFixState extends State<formDecorationOutlineFix> {
  late final Icon iconLogo;
  late final String stringHintText;
  late final InputDecoration inputDecoration;
  
  String? usernameValidator(String? value){
    if(value == null || value.isEmpty){
      return "Username is required";
    }
    if(value.length < 6){
      return "Minimum 6 characters";
    }
    return null;
  }

  String? passwordValidator(String? value){
    if(value == null || value.isEmpty){
      return "Password is required";
    }
    if(value.length < 8){
      return "Minimum 8 characters";
    }
  }

  String? emailValidator(String? value){
    if(value == null || value.isEmpty){
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if(!emailRegex.hasMatch(value)){
      return "Invalid email format";
    }
  }

  bool _obscurePassword = true;

  void initState(){
    super.initState();

    if(widget.textHint == "username"){
      iconLogo = Icon(Icons.person);
      stringHintText = "Enter your username";
      _obscurePassword = false;
    }
    else if(widget.textHint == "password"){
      iconLogo = Icon(Icons.lock);
      stringHintText = "Enter your password";
      _obscurePassword = true;
    }
    else if(widget.textHint == "email"){
      iconLogo = Icon(Icons.email_outlined);
      stringHintText = "Enter your email";
      _obscurePassword = false;
    }
  }

  String? inputValidator(String? value){
    switch(widget.textHint){
      case "username":
        return usernameValidator(value);
      case "password":
        return passwordValidator(value);
      case "email":
        return emailValidator(value);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: inputValidator,
      obscureText:  _obscurePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        hintText: stringHintText,
        prefixIcon: iconLogo,
        suffixIcon: widget.textHint == "password" ?
          IconButton(onPressed: (){
            setState((){
              _obscurePassword = !_obscurePassword;
            });
          }, icon: _obscurePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility)) : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(153, 0, 0, 0)),
          borderRadius: BorderRadius.all(Radius.circular(15))
        )
      ),
    );
  }
}

class UsernameFormWidget extends StatelessWidget {
  final TextEditingController controller;
  
  const UsernameFormWidget({super.key, required this.controller});

  @override 
  Widget build(BuildContext buildContext){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediumGabarito(text: "Username", color: Color.fromARGB(153, 0, 0, 0), textAlign: TextAlign.start),
        const SizedBox(height: 7,),
        formDecorationOutlineFix(controller: controller, textHint: "username") // styling purposes, using referencing
      ],
    );
  }
}

class PasswordFormWidget extends StatelessWidget {
  final TextEditingController controller;
  const PasswordFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediumGabarito(text: "Password", color: Color.fromARGB(153, 0, 0, 0), textAlign: TextAlign.start),
        const SizedBox(height: 7,),
        formDecorationOutlineFix(controller: controller, textHint: "password") // styling purposes, using referencing
      ],
    );
  }
}

class EmailFormWidget extends StatelessWidget {
  final TextEditingController controller;
  const EmailFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediumGabarito(text: "Email", color: Color.fromARGB(153, 0, 0, 0), textAlign: TextAlign.start),
        const SizedBox(height: 7,),
        formDecorationOutlineFix(controller: controller, textHint: "email") // styling purposes, using referencing
      ],
    );
  }
}