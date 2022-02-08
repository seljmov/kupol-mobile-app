import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/technician/entity/entity_form/users/components/user_model.dart';
import 'package:kupol_app/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var lastnameController = TextEditingController();
  var firstnameController = TextEditingController();
  var patronymicController = TextEditingController();
  var phoneController = MaskedTextController(
    mask: '0 (000) 000-00-00',
  );
  var addressController = TextEditingController();
  var pinController = TextEditingController();

  @override
  void initState() {
    if (widget.user != null) {
      lastnameController.text = widget.user!.lastname;
      firstnameController.text = widget.user!.firstname;
      patronymicController.text = widget.user!.patronymic;
      phoneController.text = widget.user!.phone;
      addressController.text = widget.user!.address;
      pinController.text = widget.user!.pin;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => catchFocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.user == null
                ? "Добавить пользователя"
                : "Изменить пользователя",
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
          padding: kDetailScreenPadding,
          physics: kDefaultPhysics,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: lastnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Фамилия",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: firstnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Имя",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: patronymicController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Отчество",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Телефон",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixText: "+",
                  prefixStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  TextField(
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: "Адрес",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyText2?.color,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "PIN",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyText2?.color,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      PinCodeTextField(
                        controller: pinController,
                        appContext: context,
                        length: 4,
                        onChanged: (value) {
                          print(value);
                        },
                        keyboardType: TextInputType.number,
                        showCursor: false,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: hintColor,
                        ),
                        pastedTextStyle: TextStyle(
                          fontSize: 16,
                          color: hintColor,
                        ),
                        pinTheme: PinTheme(
                          fieldOuterPadding: EdgeInsets.only(right: 12),
                          fieldWidth: 30,
                          fieldHeight: 40,
                          shape: PinCodeFieldShape.underline,
                          activeColor: secondaryGreyColor,
                          inactiveColor: secondaryGreyColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Сохранить"),
                  ),
                ],
              ),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
