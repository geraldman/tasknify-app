import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/custom-button.dart';
import 'styles/styles.dart';
import 'get-started.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasknify',
      home: Scaffold(
        backgroundColor: Color(0xffFCFBFC),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              PrimaryGabarito(text: "Tasknify", color: Color(0xff004AAD),textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RegularGabarito(text: "Upgrade your notes-taking \nexperience", color:Colors.black ,textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50), // raise the button
                child: Builder(
                  builder: (context) => PrimaryButton(
                    text: "Get Started",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterLoginBaseFrame()),
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