import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/responsive/mobileScreenLayout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/responsive/webScreenLayout.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_feild_input.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<login_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUser(
        email: emailController.text, password: passwordController.text);

// CODE THAT SHIFTS TO THE NEXT PAGE
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webScreenLayout: webScreenLayout(),
                mobileScreenLayout: mobileScreenLayout())),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const signup_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),

            //image
            SvgPicture.asset(
              'assets/logo.svg',
              color: primaryColor,
              height: 64,
            ),

            //TextField input for email
            const SizedBox(height: 64),
            TextFieldInput(
              hintText: "Enter your email",
              isPass: false,
              textInputType: TextInputType.emailAddress,
              TextEditingController: emailController,
            ),

            const SizedBox(height: 24),
            //TextField input for password
            TextFieldInput(
              hintText: "Enter your password",
              isPass: true,
              textInputType: TextInputType.emailAddress,
              TextEditingController: passwordController,
            ),
            const SizedBox(height: 24),

            //button login
            InkWell(
              onTap: logInUser,
              child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ))),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(child: Container(), flex: 2),

            //transitioning to Sign up

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    child: const Text("Don't have an account ?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
                Container(
                  child: const Text("Sign up.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
