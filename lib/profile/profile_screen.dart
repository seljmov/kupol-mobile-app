import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/employee_model.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/profile/components/default_profile_avatar.dart';
import 'package:kupol_app/profile/components/edit_avatar_button.dart';
import 'package:kupol_app/theme.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.employee}) : super(key: key);

  final Employee employee;
  final _editableNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
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
                        Stack(
                          children: [
                            DefaultProfileAvatar(),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: EditAvatarButton(),
                            ),
                          ],
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
                      decoration: const InputDecoration(
                        hintText: "mylogin",
                        labelText: "Логин",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      readOnly: !isEditable,
                      decoration: InputDecoration(
                        hintText: "mylogin",
                        labelText: "Телефон",
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
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
        );
      },
    );
  }
}
