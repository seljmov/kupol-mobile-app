import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:kupol_app/components/change_theme_notifier.dart';
import 'package:kupol_app/components/employee_model.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/components/settings_repository.dart';
import 'package:kupol_app/components/user_role.dart';
import 'package:kupol_app/gbr/events_screen.dart';
import 'package:kupol_app/sandbox_screen.dart';
import 'package:kupol_app/security/events_screen.dart';
import 'package:kupol_app/technician/technician_screen.dart';
import 'package:kupol_app/theme.dart';
import 'package:kupol_app/welcome/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var theme = await SettingsRepository().getThemeMode();

  return runApp(
    ChangeNotifierProvider(
      create: (context) => ChangeThemeNotifier(theme),
      builder: (context, child) {
        return EasyDynamicThemeWidget(
          initialThemeMode: theme,
          child: KupolApp(
            themeMode: theme,
          ),
        );
      },
    ),
  );
}

class KupolApp extends StatelessWidget {
  KupolApp({Key? key, required this.themeMode}) : super(key: key);

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeThemeNotifier>(
      builder: (context, notifier, child) {
        return MaterialApp(
          title: "Kupol App",
          debugShowCheckedModeBanner: false,
          theme: notifier.themeMode == ThemeMode.light
              ? lightThemeData
              : darkThemeData,
          home: StartUp(),
        );
      },
    );
  }
}

class StartUp extends StatelessWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: Переписать авторизацию
    return FutureBuilder<Employee?>(
      future: EmployeeRepository().getEmployeeInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        //return SandboxScreen();

        var employee = snapshot.data;
        if (employee == null) return LoginScreen();

        if (employee.role == UserRole.Security) return EventsScreen();
        if (employee.role == UserRole.Gbr) return EventsScreenGbr();
        if (employee.role == UserRole.Technician) return TechnicianScreen();

        return Scaffold(
          body: Center(
            child: Text("При авторизации что-то пошло не так..."),
          ),
        );
      },
    );
  }
}
