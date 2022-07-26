import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late  GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
       _googleSignIn = GoogleSignIn(
        clientId: '837356858900-3aahn0oasi8c9ebe6sia6t5hkccerefi.apps.googleusercontent.com',
        serverClientId: '407871450236-bpehuinb1fbjq1t2dim3lr90ksmgq603.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
  
  }

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Text(
              'Login with google',
            ),
            ElevatedButton(onPressed: () {
               _googleSignIn.signIn().then((value) => 
              Navigator.of(context).pushNamed('/survey')

               ).catchError((e) {
                /// broken
               });
            }, child: const Text('Login'))
          ],
        ),
      ),
    );
    }
  }