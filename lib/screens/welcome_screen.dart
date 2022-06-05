import 'package:flutter/material.dart';
import 'package:pr4_media_booster_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  setValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    finalEmail = prefs.getString('SignUpEmail');
    finalPassword = prefs.getString('SignUpPassword');
    finalUsername = prefs.getString('SignUpUsername');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    setValue();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: const Alignment(-0.6,0.75),
            children: [
              Transform.scale(
                scale: 1,
                child: Image.asset(
                  'assets/images/pertten2.png',
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
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Welcome',
              style: TextStyle(
                color: mainDarkColor,
                fontSize: 70,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'back',
              style: TextStyle(
                letterSpacing: 1.5,
                color: mainLightColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          h60,
          Padding(
            padding: const EdgeInsets.only(right: 40,left: 40),
            child: GestureDetector(
              onTap: (){

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
                    )
                ),
                child:  Text(
                  'Login as $finalUsername',
                  style: const  TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          h60,
          Center(
            child: GestureDetector(
              onTap: () async {

                Navigator.of(context).pushReplacementNamed('sign_up_screen');

                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                await prefs.remove('isLoggedIn');
                await prefs.remove('isRegisteredIn');
                await prefs.remove('SignUpEmail');
                await prefs.remove('SignUpPassword');
                await prefs.remove('SignUpUsername');
                await prefs.remove('SignInPassword');
                await prefs.remove('SignInUsername');

              },
              child: const Text('Delete account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
