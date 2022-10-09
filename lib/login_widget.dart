import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:proyecto_transporte_publico_jj/pages/forgot_password_page.dart';
import 'package:proyecto_transporte_publico_jj/utils.dart';
import './main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        print(e);

        Utils.showSnackBar(e.message);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          TextField(
            controller: _emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Correo Electrónico'),
          ),
          SizedBox(height: 4),
          TextField(
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            onPressed: signIn,
            icon: Icon(
              Icons.lock_open,
              size: 32,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 24),
          GestureDetector(
            child: Text(
              'Olvidaste tu contraseña?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForgotPasswordPage(),
            )),
          ),
          SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              text: 'Aún no eres miembro?  ',
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Regístrate Ahora',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
