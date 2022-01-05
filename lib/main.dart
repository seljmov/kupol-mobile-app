import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:kupol_app/security/events_screen.dart';
import 'package:kupol_app/theme.dart';

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
    return EventsScreen();
  }
}
