import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasknify/styles/styles.dart';

class CustomButton extends StatelessWidget{
  final String text;
  final Color textColor;
  final double fontSize;
  final VoidCallback? onPressed;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry innerPadding;
  final double? width;
  final double? height;
  final Color borderColor;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onPressed,
    required this.color,
    required this.fontSize,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.0,
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
          side: BorderSide(color: borderColor, width: borderWidth)
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent
      ).copyWith(
        overlayColor: WidgetStateProperty.all(Colors.transparent)
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

class PrimaryInvertedButton extends CustomButton{
  const PrimaryInvertedButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.borderRadius,
    super.innerPadding,
    super.width,
    super.height,
  }) : super(
    color: Colors.transparent,
    textColor: const Color(0xff004AAD),
    fontSize: 20,
    borderColor: const Color(0xff004AAD),
  );
}

enum AuthButtonMode{
  toggle, back,
}

class RegisterLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String frameState;
  final AuthButtonMode mode;
  final bool isExpanding;

  const RegisterLoginButton({
    super.key,
    required this.frameState,
    required this.onPressed,
    this.mode = AuthButtonMode.toggle,
    this.isExpanding = false
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
      child: LayoutBuilder(
        builder:(context, constraints) {
          final double fullWidth = constraints.maxWidth;
          final double halfWidth = fullWidth / 2;

        return Stack(
          children: [
            /// 🔥 ANIMATED INDICATOR (THIS IS THE MAGIC)
            AnimatedAlign(
              key: const ValueKey("auth-pill"),
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              alignment: mode == AuthButtonMode.back
                  ? Alignment.center
                  : frameState == "login"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

              /// 🔒 FIX: alignment gets a STABLE size
              child: SizedBox(
                width: mode == AuthButtonMode.back
                  ? fullWidth
                  : halfWidth, // ← constant reference for sliding

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.fastEaseInToSlowEaseOut,

                  /// expansion happens INSIDE
                  width: mode == AuthButtonMode.back && isExpanding
                      ? fullWidth
                      : halfWidth,

                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  /// 🔄 GO BACK CONTENT (unchanged)
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 700),
                    switchInCurve: Curves.easeInOutExpo,
                    switchOutCurve: Curves.easeInOutExpo,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: mode == AuthButtonMode.back
                        ? Center(
                            key: const ValueKey("back"),
                            child: RegularButtonGabarito(
                              text: "Go Back",
                              color: Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox.shrink(
                            key: ValueKey("empty"),
                          ),
                  ),
                ),
              ),
            ),

        
            /// BUTTON LAYER (ONLY WHEN TOGGLE)
            if (mode == AuthButtonMode.toggle)
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: frameState == "register"
                          ? null
                          : onPressed,
                      style: frameState == "register" ? _buttonStyle(1) : _buttonStyle(0),
                      child: RegularButtonGabarito(
                        text: "Register",
                        color: frameState == "register"
                            ? Colors.black
                            : Colors.black26,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: frameState == "login"
                          ? null
                          : onPressed,
                      style: frameState == "login" ? _buttonStyle(1) : _buttonStyle(0),
                      child: RegularButtonGabarito(
                        text: "Log in",
                        color: frameState == "login"
                            ? Colors.black
                            : Colors.black26,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
        
            /// TAP AREA FOR GO BACK
            if (mode == AuthButtonMode.back)
              Positioned.fill(
                child: TextButton(
                  onPressed: onPressed,
                  style: _buttonStyle(0),
                  child: const SizedBox.shrink(),
                ),
              ),
            ]
          );
        },
      ),
    );
  }

  ButtonStyle _buttonStyle(int active) {
    if(active == 1){
      return TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        )
      ).copyWith(
        overlayColor:
            WidgetStateProperty.all(Colors.transparent),
      );
    }
    else{
      return TextButton.styleFrom().copyWith(
        overlayColor: WidgetStateProperty.all(Colors.transparent)
      );
    }
  }
}