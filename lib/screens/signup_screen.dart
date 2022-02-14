import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/responsive/mobileScreenLayout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/responsive/webScreenLayout.dart';
import 'package:instagram_flutter/screens/login_Screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_feild_input.dart';

class signup_Screen extends StatefulWidget {
  const signup_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<signup_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      bio: bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      if (res == "success") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  webScreenLayout: webScreenLayout(),
                  mobileScreenLayout: mobileScreenLayout())),
        );
      }
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const login_Screen()));
  }

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
            const SizedBox(height: 64),

            //circular widget to show our selected component
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOMuKqVG-X6aOwtt1N6d9zaV5hmwvmdRXlt--LMLMMv-lw0IDY9oKxr2AA3tQadm5x5n0&usqp=CAU"),
                      ),
                Positioned(
                  bottom: -14,
                  left: 93,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),

            TextFieldInput(
              hintText: "Enter your username",
              isPass: false,
              textInputType: TextInputType.text,
              TextEditingController: usernameController,
            ),
            const SizedBox(height: 24),

            TextFieldInput(
              hintText: "Enter your bio",
              isPass: false,
              textInputType: TextInputType.text,
              TextEditingController: bioController,
            ),
            const SizedBox(height: 24),

            //TextField input for email

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
              onTap: signUpUser,
              child: Container(
                  child: _isLoading
                      ? Center(
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Sign Up"),
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
                  onTap: navigateToLogin,
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
