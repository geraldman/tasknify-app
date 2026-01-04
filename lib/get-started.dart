import 'package:flutter/material.dart';
import 'package:tasknify/widget/form-widget.dart';
import 'widget/custom-button.dart';
import 'styles/styles.dart';

class RegisterLoginBaseFrame extends StatelessWidget{
  const RegisterLoginBaseFrame({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff004AAD),
      resizeToAvoidBottomInset: true,
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
  bool isLogin = false;
  int registerStep = 1;
  bool isExpanding = false;

  void toggleForm(){
    setState(() {
      isLogin = !isLogin;
      registerStep = 1;
    });
  }

  void goToNextRegisterStep(){
    setState((){
      registerStep++;
    });
  
    Future.delayed(const Duration(milliseconds: 400), () {
    if (!mounted) return;
      setState(() {
        isExpanding = true;
      });
    });
  }

  void goBackRegisterStep(){
    setState((){
      if(registerStep > 1){
        registerStep--;
      }
      else{
        isLogin = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showGoBack = !isLogin && registerStep > 1;

    return Column(
      children: [
        RegisterLoginButton(
          key: const ValueKey("auth-header"),
          isExpanding: isExpanding,
          mode: showGoBack
            ? AuthButtonMode.back
            : AuthButtonMode.toggle,
          frameState: isLogin ? "login" : "register", 
          onPressed: showGoBack
            ? goBackRegisterStep
            : toggleForm
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
          : RegisterPageState(step: registerStep, key: ValueKey("register"), onNext: goToNextRegisterStep,)
        )
      ],
    );
  }
}

class RegisterPageState extends StatelessWidget {
  final int step;
  final VoidCallback onNext;

  const RegisterPageState({
    super.key,
    required this.step,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return step == 1
        ? RegisterFormOne(onNext: onNext)
        : const RegisterFormTwo();
  }
}

class RegisterFormOne extends StatefulWidget{
  final VoidCallback? onNext;

  const RegisterFormOne({
    super.key,
    required this.onNext
  });

  @override
  State<RegisterFormOne> createState() => _RegisterFormOneState();
}

class _RegisterFormOneState extends State<RegisterFormOne> {
  final _registerKeyOne = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState(){
    super.initState();
    _usernameController.addListener(_validateForm);
  } 

  void _validateForm(){
    final valid = _registerKeyOne.currentState?.validate() ?? false;
    if(valid != isFormValid){
      setState((){
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerKeyOne,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          UsernameFormWidget(controller: _usernameController,),
          SizedBox(height: 38,),
          SizedBox(
            width: double.infinity,
            child: PrimaryInvertedButton(
              text: "Next", 
              onPressed: isFormValid ? widget.onNext : null,
            ),
          )
         ],
      ),
    );
  }
}

class RegisterFormTwo extends StatefulWidget{
  final VoidCallback? onNext;
  const RegisterFormTwo({super.key, this.onNext});

  @override
  State<RegisterFormTwo> createState() => _RegisterFormTwoState();
}

class _RegisterFormTwoState extends State<RegisterFormTwo> {
  final _registerKeyTwo = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState(){
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm(){
    final valid = _registerKeyTwo.currentState?.validate() ?? false;
    if(valid != isFormValid){
      setState((){
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerKeyTwo,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          EmailFormWidget(controller: _emailController),
          SizedBox(height: 18,),
          PasswordFormWidget(controller: _passwordController),
          SizedBox(height: 38,),
          SizedBox(
            width: double.infinity,
            child: PrimaryInvertedButton(
              text: "Next",
              onPressed: isFormValid ? widget.onNext : null,
            ),
          )
         ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget{
  final VoidCallback? onLogin;
  const LoginForm({super.key, this.onLogin});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState(){
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm(){
    final valid = _loginKey.currentState?.validate() ?? false;
    if(valid != isFormValid){
      setState((){
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          EmailFormWidget(controller: _emailController),
          SizedBox(height: 18,),
          PasswordFormWidget(controller: _passwordController),
          SizedBox(height: 38,),
          SizedBox(
            width: double.infinity,
            child: PrimaryInvertedButton(
              text: "Log in",
              onPressed: isFormValid ? widget.onLogin : null,
            ),
          ),
         ],
      ),
    );
  }
}

