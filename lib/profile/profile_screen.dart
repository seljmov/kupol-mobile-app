import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/change_theme_notifier.dart';
import 'package:kupol_app/shared/models/employee_model.dart';
import 'package:kupol_app/shared/repositories/employee_repository.dart';
import 'package:kupol_app/shared/repositories/settings_repository.dart';
import 'package:kupol_app/shared/widgets/full_screen_view.dart';
import 'package:kupol_app/shared/widgets/image_selector.dart';
import 'package:kupol_app/profile/components/default_profile_avatar.dart';
import 'package:kupol_app/profile/components/edit_avatar_button.dart';
import 'package:kupol_app/theme.dart';
import 'package:kupol_app/welcome/login/login_screen.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.employee}) : super(key: key);

  final Employee employee;
  final _editableNotifier = ValueNotifier<bool>(false);
  final _profileImageNotifier = ValueNotifier<File?>(null);

  Future<void> _logoutEmployee(BuildContext context) async {
    await EmployeeRepository().removeInfoFromStorage();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _updateInfo(
      BuildContext context, Employee employee, String phone) async {
    var newEmployee = Employee(
      id: employee.id,
      lastname: employee.lastname,
      firstname: employee.firstname,
      patronymic: employee.patronymic,
      phone: phone,
      address: employee.address,
      role: employee.role,
      pin: employee.pin,
      login: employee.login,
      password: employee.password,
    );

    await EmployeeRepository().saveEmployeeInfo(
      newEmployee.toJson(),
    );

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
                "lib/assets/icons/success.svg",
              ),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Ваше данные успешно обновлены",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier = context.read<ChangeThemeNotifier>();
    var phoneController = MaskedTextController(
      text: employee.phone,
      mask: '0 (000) 000-00-00',
    );
    return ValueListenableBuilder<bool>(
      valueListenable: _editableNotifier,
      builder: (context, isEditable, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Профиль"),
              leading: isEditable
                  ? GestureDetector(
                      onTap: () {
                        _editableNotifier.value = false;
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.redAccent,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
              actions: [
                if (isEditable)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () async {
                        var phone = phoneController.text;
                        await _updateInfo(context, employee, phone);
                        _editableNotifier.value = false;
                      },
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ValueListenableBuilder<File?>(
                            valueListenable: _profileImageNotifier,
                            builder: (context, file, child) {
                              return Stack(
                                children: [
                                  file == null
                                      ? DefaultProfileAvatar()
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenView(
                                                  child: Image.file(file),
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            child: Image.file(
                                              file,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        var images = await ImageSeletor()
                                            .select(context);
                                        if (images.length > 0) {
                                          _profileImageNotifier.value =
                                              images.first.file;
                                        }
                                      },
                                      child: EditAvatarButton(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${employee.getFullname()}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: !isEditable
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  employee.role,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: employee.login,
                          labelText: "Логин",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2?.color,
                        ),
                        controller: phoneController,
                        readOnly: !isEditable,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Телефон",
                          prefixText: "+",
                          prefixStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodyText2?.color,
                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: !isEditable
                              ? IconButton(
                                  onPressed: () {
                                    _editableNotifier.value = true;
                                  },
                                  icon: SvgPicture.asset(
                                    "lib/assets/icons/pen2.svg",
                                    width: 18,
                                  ),
                                )
                              : Text(""),
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Настройки",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SwitchListTile.adaptive(
                            onChanged: (bool setDark) async {
                              var newtheme =
                                  setDark ? ThemeMode.dark : ThemeMode.light;
                              await SettingsRepository().saveThemeMode(
                                newtheme,
                              );
                              themeNotifier.changeTheme(newtheme);
                            },
                            value: themeNotifier.themeMode == ThemeMode.dark,
                            title: Text(
                              "Использовать темную тему",
                            ),
                            contentPadding: EdgeInsets.zero,
                            activeTrackColor: secondaryColor.withOpacity(
                              0.5,
                            ),
                            activeColor: secondaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.NO_HEADER,
                            headerAnimationLoop: false,
                            customHeader: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondaryColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.door_back_door_outlined,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: "Выход из приложения",
                            desc: "Вы точно ходите выйти из приложения?",
                            btnCancel: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Отмена"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.grey,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            btnOk: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _logoutEmployee(context);
                                },
                                child: Text("Да"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.redAccent,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.redAccent,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )..show();
                        },
                        /*
                        onPressed: () => showDialog<String>(
                          barrierColor: Colors.black87,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              "Вы точно хотите выйти?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Отменить",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await _logoutEmployee(context);
                                },
                                child: const Text(
                                  "Да",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        */
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: secondaryColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "Выйти из аккаунта",
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
