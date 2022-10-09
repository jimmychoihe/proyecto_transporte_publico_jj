import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:proyecto_transporte_publico_jj/main.dart';
import 'package:proyecto_transporte_publico_jj/utils.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpWidget({super.key, required this.onClickedSignIn});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

final formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  _confirmPasswordController.dispose();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    Future signUp() async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            TextFormField(
              controller: _emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Introduce un correo electrónico valido'
                      : null,
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 8
                  ? 'Introduce una contraseña de al menos 8 caracteres'
                  : null,
            ),
            SizedBox(height: 4),
            TextFormField(
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Comfirmar Contraseña'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Comfirmación de Contraseña Requerida';
                  }
                  if (value != _passwordController.text.trim()) {
                    return 'Las Contraseñas no coinciden';
                  }
                  return null;
                }),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: signUp,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 32,
              ),
              label: Text(
                'Sign Up',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 24),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                text: 'Ya eres miembro?  ',
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Iniciar sesión ahora',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
