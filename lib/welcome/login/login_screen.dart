import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/security/events_screen.dart';
import 'package:kupol_app/welcome/repositories/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _loginController = TextEditingController(text: "testgbr");
  final _passwordController = TextEditingController(text: "testgbr");

  Future<void> _authorizeUser(
      BuildContext context, String login, String password) async {
    var response = await AuthRepository().authorizeUser(login, password);
    var endedWithError = response.toLowerCase().contains(errorPattern);

    if (endedWithError) {
      var message = response.split(errorPattern).last;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "lib/assets/icons/error.svg",
                ),
                SizedBox(width: 25),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
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
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
                controller: _loginController,
                decoration: const InputDecoration(
                  hintText: "Введите логин",
                  labelText: "Логин",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
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
      ),
    );
  }
}
