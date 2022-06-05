import 'package:flutter/material.dart';
import 'package:pr4_media_booster_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> signInKey = GlobalKey();

  TextEditingController signInUsernameController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Transform.scale(
                  scale: 1,
                  child: Image.asset(
                    'assets/images/pertten1.png',
                  ),
                ),
                Container(
                  height: 135,
                  width: 135,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/main logo.png'),
                      scale: 4.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 15.0,
                        spreadRadius: 0.0,
                      ), //BoxShadowBoxShadow
                    ],
                  ),
                ),
              ],
            ),
            h10,
            Text(
              'Sign In',
              style: TextStyle(
                color: mainDarkColor,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'account',
              style: TextStyle(
                color: mainLightColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            h25,
            Form(
              key: signInKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Column(
                  children: [
                    TextFormField(
                      controller: signInUsernameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.account_circle),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Username First";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        signInUsername = val;
                      },
                    ),
                    h30,
                    TextFormField(
                      controller: signInPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: (isVisible)
                              ? const Icon(
                                  Icons.visibility,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                ),
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Password First";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        signUpPassword = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            h10,
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: mainDarkColor,
                    value: keepLoginMe,
                    onChanged: (val) async {
                      setState(() {
                        keepLoginMe = val!;
                      });
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('isLoggedIn', keepLoginMe);
                    },
                  ),
                  Text(
                    'Keep me Logged In',
                    style: TextStyle(
                        color: mainDarkColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            h50,
            h10,
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: GestureDetector(
                onTap: () async {
                  if (signInKey.currentState!.validate()) {
                    signInKey.currentState!.save();

                    final SharedPreferences pref =
                        await SharedPreferences.getInstance();

                    if (pref.getString('SignUpUsername') ==
                            signInUsernameController.text &&
                        pref.getString('SignUpPassword') ==
                            signInPasswordController.text) {
                      Navigator.of(context)
                          .pushReplacementNamed('welcome_screen');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Invalid Username or Password...',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    }

                    pref.setString('SignInUsername', signInUsername!);
                    pref.setString('SignInPassword', signInPassword!);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      color: mainDarkColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(
                            0.0,
                            2.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ), //BoxShadowBoxShadow
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          mainLightColor,
                          mainLightColor,
                          mainLightColor,
                          mainDarkColor,
                          mainDarkColor,
                        ],
                      )),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            h50,
            h50,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed('sign_up_screen');
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: mainLightColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            h40,
          ],
        ),
      ),
    );
  }
}
