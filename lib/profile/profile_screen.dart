import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/employee_model.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/components/image_selector.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/profile/components/default_profile_avatar.dart';
import 'package:kupol_app/profile/components/edit_avatar_button.dart';
import 'package:kupol_app/theme.dart';
import 'package:kupol_app/welcome/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final _editableNotifier = ValueNotifier<bool>(false);
  final _profileImageNotifier = ValueNotifier<File?>(null);

  Future<void> _logoutEmployee(BuildContext context) async {
    await EmployeeRepository().removeInfo();
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
    await EmployeeRepository().removeInfo();
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
    return FutureBuilder<Employee?>(
      future: EmployeeRepository().getEmployeeInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var employee = snapshot.data!;
        var _phoneController = TextEditingController(text: employee.phone);
        return ValueListenableBuilder<bool>(
          valueListenable: _editableNotifier,
          builder: (context, isEditable, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Профиль"),
                leading: isEditable
                    ? GestureDetector(
                        onTap: () {
                          _editableNotifier.value = false;
                        },
                        child: Icon(Icons.close_rounded),
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
                          var phone = _phoneController.text;
                          await _updateInfo(context, employee, phone);
                          _editableNotifier.value = false;
                        },
                        child: Icon(Icons.check_rounded),
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
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            child: Image.file(
                                              file,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          var file = await ImageSeletor()
                                              .select(context);
                                          if (file != null) {
                                            _profileImageNotifier.value = file;
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
                                    getRoleName(employee.role),
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
                          controller: _phoneController,
                          readOnly: !isEditable,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Телефон",
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
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
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
            );
          },
        );
      },
    );
  }
}
