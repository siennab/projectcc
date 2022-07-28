import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_cc/model/user.dart';
import 'package:project_cc/services/questions_service.dart';
import 'package:project_cc/services/user_service.dart';

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
      clientId:
          '837356858900-3aahn0oasi8c9ebe6sia6t5hkccerefi.apps.googleusercontent.com',
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    QuestionService().getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login with google',
            ),
            ElevatedButton(
                onPressed: () {
                  _googleSignIn.signIn().then((value) {
                    if (value != null) {
                      UserService().registerUser(
                          newUser: User(id: '0', email: value!.email));
                      Navigator.of(context).pushNamed('/survey');
                    }
                  }).catchError((e) {
                    /// show error message
                  });
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
