import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/const/themeColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(45),
              width: 330,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/foodtukk1.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Themes.color,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 225.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google, color: Colors.black54),
                      SizedBox(width: 10.0),
                      Text(
                        'Sign in With Google',
                        style: TextStyle(color: Colors.black, fontSize: 17.0),
                      ),
                    ],
                  ),
                  onPressed: () {
                    _signInWithGoogle(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 15.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Your Email",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _toggleVisibility = !_toggleVisibility;
                            });
                          },
                          icon: _toggleVisibility
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _toggleVisibility,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              child: Container(
                height: 50.0,
                width: 250,
                decoration: BoxDecoration(
                  color: Themes.color,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [BoxShadow(blurRadius: 3, color: Themes.color)],
                ),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              onTap: () {
                _signInWithEmail();
              },
            ),
            Divider(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
                ),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      print('Google sign-in was canceled');
      return; // Exit the function
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    User userDetails = userCredential.user!;

    // Access provider data
    String providerId = userDetails.providerData.first.providerId;

    ProviderDetails providerInfo = ProviderDetails(providerId);

    List<ProviderDetails> providerData = <ProviderDetails>[];
    providerData.add(providerInfo);

    UserDetails details = UserDetails(
      providerId,
      userDetails.displayName ?? '',
      userDetails.email ?? '',
      userDetails.photoURL ?? '',
      providerData,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(detailsUser: details),
      ),
    );
  }


  void _signInWithEmail() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((UserCredential user) {
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String userEmail;
  final String photoUrl;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.userEmail, this.photoUrl, this.providerData);
}

class ProviderDetails {
  final String providerDetails;

  ProviderDetails(this.providerDetails);
}
