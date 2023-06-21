import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revfood/location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool seepw = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(Object context) {
    return Scaffold(
      body: SingleChildScrollView(
        //s physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  /////Back Icon
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 70, 350, 0),
                    child: IconButton(
                        splashColor: const Color.fromARGB(101, 230, 230, 230),
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(this.context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffb22222),
                          size: 35.0,
                        )),
                  ),
                  /////animation
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(left: 50, top: 80),
                    child:
                        Lottie.asset('assets/animation/login_animation.json'),
                  ),
                  /////email page
                  Container(
                    width: double.infinity,
                    height: 500,
                    margin: const EdgeInsets.only(top: 320),
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      children: [
                        Container(
                          height: 85,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Personal E-mail',
                                labelStyle: const TextStyle(fontSize: 18),
                                hintText: 'enter your e-mail',
                                hintStyle: const TextStyle(fontSize: 17),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xffb22222),
                                )),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Email");
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                          ),
                        ),
                        /////password page
                        SizedBox(
                          height: 85,
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(fontSize: 18),
                              hintText: 'enter your password',
                              hintStyle: const TextStyle(fontSize: 17),
                              prefixIcon: const Icon(
                                Icons.vpn_key,
                                color: Color(0xffb22222),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                          ),
                        ),
                        ////////////////
                        //login button
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: ElevatedButton(
                              onPressed: () {
                                signIn(emailController.text,
                                    passwordController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(270, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: const Color(0xffb22222)),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 150),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        ///////////////
                        //devider
                        const OrDivider(),
                        //socialIcons
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SocialIcon(
                                iconSrc: FontAwesomeIcons.facebook,
                                press: () async {
                                  await signInWithFacebook();
                                  final result =
                                      await FacebookAuth.instance.login();

                                  if (result.status == LoginStatus.success) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      this.context,
                                      MaterialPageRoute(
                                        builder: (context) => WillPopScope(
                                          onWillPop: () async {
                                            // Disable back button functionality
                                            return false;
                                          },
                                          child: const Location(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SocialIcon(
                                iconSrc: FontAwesomeIcons.google,
                                press: () async {
                                  await signInWithGoogle();
                                },
                              ),
                              SocialIcon(
                                iconSrc: FontAwesomeIcons.twitter,
                                press: () {
                                  signInWithTwitter();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  /////REVFOOD writing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 790),
                        height: 59,
                        child: const Text(
                          'RevFood',
                          style: TextStyle(
                            color: Color(0xFFb22222),
                            fontSize: 40.0,
                            fontFamily: 'lol',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//Connecting With Facebook with firebase
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

//Connecting With Twitter with firebase
  Future<UserCredential?> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'SlifbhbllFOGj9dZbKY1WOpad',
      apiSecretKey: 'qkOrSTRnTNY4WMT8KfbqdcwnJIL438GNBYWQmzdoRXE8RKDiQO',
      redirectURI: "revfood://",
    );
    final authResult = await twitterLogin.login();
    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async {
              // Disable back button functionality
              return false;
            },
            child: const Location(),
          ),
        ),
      );

      return userCredential;
    } else if (authResult.status == TwitterLoginStatus.cancelledByUser) {
      // User cancelled the login process
    } else {
      // Error occurred during login
      // ignore: unused_local_variable
      final errorMessage = authResult.errorMessage;
      // Handle the error
    }

    // Return null if no userCredential is available
    return null;
  }

//Connecting With Google with firebase
  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // ignore: use_build_context_synchronouslyInfo.plist, use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async {
              // Disable back button functionality
              return false;
            },
            child: const Location(),
          ),
        ),
      );

      return userCredential;
    }

    return null;
  }

//Login With firebase
  Future signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: email.trim(), password: password.trim())
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Location())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }
}

class SocialIcon extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final iconSrc;
  final Function? press;
  const SocialIcon({
    super.key,
    this.iconSrc,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: const Color(0xffb22222)),
              shape: BoxShape.circle),
          child: FaIcon(
            iconSrc,
            size: 35,
            color: const Color(0xffb22222),
          )),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      width: size.width * 0.6,
      child: Row(
        children: <Widget>[
          buildDivider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: Color(0xffb22222),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        color: Color.fromARGB(255, 19, 19, 19),
        height: 1.5,
      ),
    );
  }
}
