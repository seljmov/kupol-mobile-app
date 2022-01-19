import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/theme.dart';

Future<void> showCreateUserBottomSheet(BuildContext context) async {
  var lastnameController = TextEditingController();
  var firstnameController = TextEditingController();
  var patronymicController = TextEditingController();
  var phoneController = MaskedTextController(
    mask: '0 (000) 000-00-00',
  );
  var addressController = TextEditingController();
  var pinController = TextEditingController();
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
                "Добавить пользователя",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: lastnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Фамилия",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: firstnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Имя",
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: patronymicController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Отчество",
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Телефон",
                  prefixText: "+",
                  prefixStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  hintStyle: TextStyle(
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
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    labelText: "Адрес",
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              SizedBox(height: 45),
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
