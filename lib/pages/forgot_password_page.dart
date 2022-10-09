import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:proyecto_transporte_publico_jj/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future resetPassword() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailcontroller.text.trim());

        Utils.showSnackBar(
            "El correo para el cambio de contraseña fué enviado");
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        print(e);

        Utils.showSnackBar(e.message);
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enviar correo para cambiar tu contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailcontroller,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Indrotuce un correo electrónico válido'
                        : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: resetPassword,
                icon: Icon(
                  Icons.email_outlined,
                  size: 32,
                ),
                label: Text(
                  'Cambiar Contraseña',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
