import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/security/events_screen.dart';
import 'package:kupol_app/welcome/repositories/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _loginController = TextEditingController(text: "test");
  final _passwordController = TextEditingController(text: "test");

  Future<void> _authorizeUser(
      BuildContext context, String login, String password) async {
    var response = await AuthRepository().authorizeUser(login, password);
    var endedWithError = response.toLowerCase().contains(errorPattern);

    if (endedWithError) {
      var message = response.split(errorPattern).last;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            message,
          ),
          action: SnackBarAction(
            onPressed: () {},
            label: "ОК",
            textColor: Colors.white,
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EventsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 128,
          horizontal: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "lib/assets/logo.png",
              height: 200,
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                hintText: "Введите логин",
                labelText: "Логин",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Введите пароль",
                labelText: "Пароль",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => _authorizeUser(
                context,
                _loginController.text,
                _passwordController.text,
              ),
              child: Text("Войти"),
            ),
          ],
        ),
      ),
    );
  }
}
