import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasknify/styles/styles.dart';

class CustomButton extends StatelessWidget{
  final String text;
  final Color textColor;
  final double fontSize;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry innerPadding;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onPressed,
    required this.color,
    required this.fontSize,
    this.borderRadius = 15.0,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: innerPadding,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.gabarito(
          textStyle: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }

    return button;
  }
}

class PrimaryButton extends CustomButton{
  const PrimaryButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.borderRadius,
    super.innerPadding,
    super.width,
    super.height,
  }) : super(
    color: const Color(0xff004AAD),
    textColor: const Color(0xffF5F5F5),
    fontSize: 20,
  );
}

class RegisterLoginButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String FrameState; // this is will determine if its changing to login or register

  const RegisterLoginButton({
    super.key,
    required this.FrameState,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xffEFEFEF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          /// 🔥 Sliding indicator
          AnimatedAlign(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            alignment: FrameState == "login"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              )
            ),
          ),

          /// Buttons layer
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: FrameState == "register"
                      ? null // already active
                      : onPressed,
                  style: TextButton.styleFrom().copyWith(
                    overlayColor: WidgetStateProperty.all(Colors.transparent)
                  ),
                  child: RegularButtonGabarito(
                    text: "Register",
                    color: FrameState == "register"
                        ? Colors.black
                        : Colors.black26,
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              Expanded(
                child: TextButton(
                  onPressed: FrameState == "login"
                      ? null // already active
                      : onPressed,
                  style: TextButton.styleFrom().copyWith(
                    overlayColor: WidgetStateProperty.all(Colors.transparent)
                  ),
                  child: RegularButtonGabarito(
                    text: "Log in",
                    color: FrameState == "login"
                        ? Colors.black
                        : Colors.black26,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}