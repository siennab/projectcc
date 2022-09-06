import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_cc/model/user.dart';
import 'package:project_cc/services/user_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
      // clientId:
      //    '837356858900-3aahn0oasi8c9ebe6sia6t5hkccerefi.apps.googleusercontent.com',
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'PROJECT CC',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 8),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  _googleSignIn.signIn().then((value) {
                    if (value != null) {
                      UserService().registerUser(
                          newUser: User(id: '0', email: value.email));
                      Navigator.of(context).pushNamed('/survey');
                    }
                  }).catchError((e) {
                    /// show error message
                  });
                },
              ),
              SignInButton(Buttons.Apple, onPressed: () {
                Navigator.of(context).pushNamed('/survey');
              }),
              SignInButton(Buttons.FacebookNew, onPressed: () {
                Navigator.of(context).pushNamed('/survey');
              }),
              SignInButton(Buttons.Twitter, onPressed: () {
                Navigator.of(context).pushNamed('/survey');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
