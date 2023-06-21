// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:revfood/Location.dart';
import 'package:revfood/Login.dart';
import 'package:revfood/user_model.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool seepw = false;

  late FocusNode _firstNameFocusNode;
  late FocusNode _familyNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _familyNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _familyNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _focusNextField(BuildContext context, FocusNode currentFocusNode) {
    FocusScope.of(context).requestFocus(currentFocusNode);
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //Head has Wave..Skip..Create acc
            ClipPath(
              //Wave
              clipper: WaveClipper(),
              child: Container(
                color: const Color.fromARGB(232, 178, 34, 34),
                height: 300,
              ),
            ),
            Container(
              //Skip
              width: 80,
              margin: const EdgeInsets.only(top: 69, left: 355),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    this.context,
                    MaterialPageRoute(builder: (context) => const Location()),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(232, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Container(
              //Create acc..Script
              margin: const EdgeInsets.only(top: 113),
              width: 450,
              height: 59,
              child: const Center(
                child: Text(
                  'Create New Account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            //Body From TextField To Revfood Script
            Form(
              key: _formKey,
              child: Container(
                //Body
                margin: const EdgeInsets.only(left: 12, top: 240),
                child: Column(
                  children: [
                    //TextFields
                    Container(
                      //FirstName TextField
                      height: 85,
                      margin: const EdgeInsets.fromLTRB(20, 35, 25, 0),
                      child: TextFormField(
                        autofocus: false,
                        focusNode: _firstNameFocusNode,
                        onEditingComplete: () {
                          _focusNextField(this.context, _familyNameFocusNode);
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'First Name',
                            labelStyle: const TextStyle(fontSize: 18),
                            hintText: 'enter your first name',
                            hintStyle: const TextStyle(fontSize: 17),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xffb22222),
                            )),
                        keyboardType: TextInputType.text,
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          firstNameController.text = value!;
                        },
                      ),
                    ),
                    Container(
                      //FamilyName TextField
                      height: 85,
                      margin: const EdgeInsets.fromLTRB(20, 5, 25, 0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Family Name',
                            labelStyle: const TextStyle(fontSize: 18),
                            hintText: 'enter your family name',
                            hintStyle: const TextStyle(fontSize: 17),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xffb22222),
                            )),
                        keyboardType: TextInputType.text,
                        controller: secondNameController,
                        focusNode: _familyNameFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _focusNextField(this.context, _emailFocusNode);
                        },
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Family Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          secondNameController.text = value!;
                        },
                      ),
                    ),
                    Container(
                      //E-mail TextField
                      height: 85,
                      margin: const EdgeInsets.fromLTRB(20, 5, 25, 0),
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
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _focusNextField(this.context, _passwordFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                    Container(
                      //Password TextField
                      height: 85,
                      margin: const EdgeInsets.fromLTRB(20, 5, 25, 0),
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
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.send,
                        onEditingComplete: () {
                          signUp(emailController.text, passwordController.text);
                        },
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
                    //Buttons
                    Container(
                      //SignUp Button
                      margin: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                          onPressed: () {
                            signUp(
                                emailController.text, passwordController.text);
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
                                margin: const EdgeInsets.only(left: 45),
                                child: const Text(
                                  'Sign Up',
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
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      //Two deviders and alreadyHave..Script
                      width: 450,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 80,
                            child: const Divider(
                              height: 25,
                              color: Color.fromARGB(255, 19, 19, 19),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 118, right: 100, top: 12),
                            height: 30,
                            child: const Text(
                              'Create an account with',
                              style: TextStyle(
                                  color: Color(0xFFb22222),
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 320),
                            width: 80,
                            child: const Divider(
                              color: Color.fromARGB(255, 19, 19, 19),
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //the Socialicons
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
                            press: () {
                              signInWithGoogle();
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
                    ),
                    //RevFoodScript
                    Container(
                      //RevFoodScript
                      padding: const EdgeInsets.only(top: 20),
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
              ),
            ),
          ],
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
    }

    return null;
  }

//Firabase With SignUp
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()});
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.secondName = secondNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Location()),
        (route) => false);
  }
}

//Class Craeting A Wave With ClipPath
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height - 120); //start path with this if you a
    var firstStart = Offset(size.width / 5, size.height - 30);
    var firstEnd = Offset(size.width / 2.25, size.height - 70.0);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 117);

    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(
        size.width, 0); //end with this path if you are making path.close()

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
