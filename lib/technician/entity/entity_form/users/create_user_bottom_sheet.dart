import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/technician/entity/entity_form/users/components/user_model.dart';
import 'package:kupol_app/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Future<void> showEditUserBottomSheet({
  required BuildContext context,
  required User user,
}) async {
  var lastnameController = TextEditingController(text: user.lastname);
  var firstnameController = TextEditingController(text: user.firstname);
  var patronymicController = TextEditingController(text: user.patronymic);
  var phoneController = MaskedTextController(
    text: user.phone,
    mask: '0 (000) 000-00-00',
  );
  var addressController = TextEditingController(text: user.address);
  var pinController = TextEditingController(text: user.pin);
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 12),
        Center(
          child: SvgPicture.asset(
            "lib/assets/icons/drop_down.svg",
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Добавить пользователя".toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontWeight: FontWeight.w600,
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
                  fontWeight: FontWeight.w600,
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
                  fontWeight: FontWeight.w600,
                ),
                controller: patronymicController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Отчество",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
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
                  fontWeight: FontWeight.w600,
                ),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Телефон",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
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
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom / 2.25,
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    labelText: "Адрес",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontWeight: FontWeight.w400,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
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
                      fontWeight: FontWeight.w600,
                    ),
                    pastedTextStyle: TextStyle(
                      fontSize: 16,
                      color: hintColor,
                      fontWeight: FontWeight.w600,
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
              SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.425, 50.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      "Отмена",
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.425, 50.0),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        primaryColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Сохранить",
                      style: TextStyle(
                        fontSize: 16,
                        color: darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 64),
      ],
    ),
  );
}
