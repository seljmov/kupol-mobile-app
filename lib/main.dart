import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:kupol_app/components/employee_model.dart';
import 'package:kupol_app/components/role.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/security/events_screen.dart';
import 'package:kupol_app/theme.dart';
import 'package:kupol_app/welcome/login/login_screen.dart';

void main() {
  return runApp(
    EasyDynamicThemeWidget(
      child: KupolApp(),
    ),
  );
}

class KupolApp extends StatelessWidget {
  const KupolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kupol App",
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: StartUp(),
    );
  }
}

class StartUp extends StatelessWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Employee?>(
      future: EmployeeRepository().getEmployeeInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        var employee = snapshot.data;
        if (employee == null) return LoginScreen();

        if (employee.role == Role.security) return EventsScreen();

        return Scaffold(
          body: Center(
            child: Text("При авторизации что-то пошло не так..."),
          ),
        );
      },
    );
  }
}
