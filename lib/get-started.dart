import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/custom-button.dart';
import 'styles/styles.dart';

class RegisterLoginBaseFrame extends StatelessWidget{
  const RegisterLoginBaseFrame({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff004AAD),
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: DefaultSideMargin(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 126.0,),
                PrimaryGabarito(text: "Get Started", color: Colors.white, textAlign: TextAlign.left),
                SizedBox(height: 10.0),
                SmallGabarito(text: "Create your account or login to explore our app", color: Colors.white, textAlign: TextAlign.left),
              ],
            ),
          ),
          SizedBox(height: 40.0,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
                ),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: DefaultSideMargin(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 34.0),
                        AuthPage(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthPage extends StatefulWidget{
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
  bool isLogin = true;

  void toggleForm(){
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterLoginButton(
          FrameState: isLogin ? "login" : "register", 
          onPressed: toggleForm
        ),
        const SizedBox(height: 23.0,),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation){
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero, 
              ).animate(animation),
              child: FadeTransition(opacity: animation, child:child), 
            );
          },
          child: isLogin 
          ? const LoginForm(key: ValueKey("login"))
          : const RegisterFormOne(key: ValueKey("register"))
        )
      ],
    );
  }

}

class RegisterFormOne extends StatelessWidget{
  const RegisterFormOne({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Register Form")
       ],
    );
  }
}

class LoginForm extends StatelessWidget{
  const LoginForm({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Login Form")
       ],
    );
  }
}

