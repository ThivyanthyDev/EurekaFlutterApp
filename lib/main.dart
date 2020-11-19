import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(child: LoginPage()),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int pageState = 0;

  var backgroundColor = Colors.white;
  var headingColor = Color(0xFFB40284A);

  double headingTop = 70;

  double loginWidth = 0;
  double loginHeight = 0;

  double loginYOffSet = 0;
  double registerYoffSet = 0;
  double loginXOffSet = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  double loginOpacity = 1;

  bool keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          keyboardVisible = visible;
          print("Keyboard State Changed : $visible");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    loginHeight = windowHeight - 230;

    switch (pageState) {
      case 0:
        backgroundColor = Colors.white;
        headingColor = Color(0xFFB40284A);

        loginWidth = windowWidth;

        loginHeight = keyboardVisible ? windowHeight : windowHeight - 230;

        loginYOffSet = windowHeight;
        loginXOffSet = 0;
        registerYoffSet = windowHeight;
        loginOpacity = 1;
        headingTop = 54;
        break;

      case 1:
        backgroundColor = Color(0xFF997185);
        headingColor = Colors.white;

        headingTop = 100;

        loginWidth = windowWidth;
        loginOpacity = 1;

        loginYOffSet = keyboardVisible ? 40 : 230;
        loginHeight = keyboardVisible ? windowHeight : windowHeight - 230;

        loginXOffSet = 0;
        registerYoffSet = windowHeight;

        break;

      case 2:
        backgroundColor = Color(0xFF997185);
        headingColor = Colors.white;

        loginWidth = windowWidth - 40;
        loginHeight = keyboardVisible ? windowHeight : windowHeight - 230;
        loginYOffSet = keyboardVisible ? 30 : 230;
        loginXOffSet = 20;
        registerYoffSet = keyboardVisible ? 40 : 230;
        
        loginOpacity = 0.7;
        headingTop = 80;

        break;
    }

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageState = 0;
                  });
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(
                          microseconds: 1000,
                        ),
                        margin: EdgeInsetsDirectional.only(
                          top: headingTop,
                        ),
                        child: Text(
                          "Eureka",
                          style: TextStyle(color: headingColor, fontSize: 48),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "We make learning easy. Join Eureka to clear your doubts at anytime",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: headingColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: Image.asset("assets/images/splash_bg.png"),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (pageState != 0) {
                        pageState = 0;
                      } else {
                        pageState = 1;
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(32),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFB40284A),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(20),
          width: loginWidth,
          height: loginHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(loginXOffSet, loginYOffSet, 1),
          decoration: BoxDecoration(
            color: Color(0xFFD3C7CD).withOpacity(loginOpacity),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Login To Continue",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  InputWithIcon(
                    icon: Icons.email,
                    hint: "Enter Email..",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWithIcon(
                    icon: Icons.vpn_key,
                    hint: "Enter Password..",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  PrimaryButton(
                    btnText: "Login",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pageState = 2;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Create New Account",
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(20),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(0, registerYoffSet, 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Create a New Account",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  InputWithIcon(
                    icon: Icons.email,
                    hint: "Enter Email..",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWithIcon(
                    icon: Icons.vpn_key,
                    hint: "Enter Password..",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  PrimaryButton(
                    btnText: "Create Account",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pageState = 1;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Back to Login",
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({this.icon, this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: widget.hint,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A), borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFB40284A), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 20),
        ),
      ),
    );
  }
}
