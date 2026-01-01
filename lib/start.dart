import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/custom-button.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasknify Start App',
      home: Scaffold(
        backgroundColor: Color(0xffFCFBFC),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 228,
                alignment: Alignment.bottomCenter,
              ),
              Text(
                "Tasknify",
                style: GoogleFonts.gabarito(
                  textStyle: TextStyle(
                    color: const Color(0xff004AAD),
                    fontSize: 50,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Upgrade your notes-taking \nexperience.",
                  style: GoogleFonts.gabarito(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      height: 1.2,
                    )
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50), // raise the button
                child: Builder(
                  builder: (context) => PrimaryButton(
                    text: "Get Started",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterFrame()),
                      );
                    },
                    width: 200,
                    height: 50,
                    innerPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class RegisterFrame extends StatelessWidget{
  const RegisterFrame({super.key});

  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("About us"),),
    );
  }
}
