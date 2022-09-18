import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_cc/components/app_bar.dart';
import 'package:project_cc/components/card.dart';
import 'package:project_cc/model/user.dart';
import 'package:project_cc/services/user_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.speed_rounded,
                size: 48,
                color: Colors.white,
              ),
              Text(
                'PROJECT CC',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  _googleSignIn.signIn().then((value) {
                    if (value != null) {
                      UserService().registerUser(
                          newUser: User(
                              thirdPartyIdentifier: value.id,
                              email: value.email));
                      Navigator.of(context).pushNamed('/survey');
                    }
                  }).catchError((e) {
                    /// show error message
                  });
                },
              ),
              if (Platform.isIOS)
                SignInButton(
                  Buttons.Apple,
                  onPressed: () async {
                    final credential =
                        await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                    );

                    if (credential.userIdentifier != null) {
                      UserService().registerUser(
                          newUser: User(
                              thirdPartyIdentifier: credential.userIdentifier!,
                              email: credential.email));
                      Navigator.of(context).pushNamed('/survey');
                    }
                    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
