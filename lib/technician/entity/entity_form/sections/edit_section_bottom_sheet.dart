import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/components/section_model.dart';
import 'package:kupol_app/theme.dart';

Future<void> showEditSectionBottomSheet({
  required BuildContext context,
  required Section section,
}) async {
  var nameController = TextEditingController(text: section.name);
  var locationController = TextEditingController(text: section.location);
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) => SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: GestureDetector(
        onTap: () => catchFocus(context),
        child: Column(
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
                    "Редактировать секцию".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontWeight: FontWeight.w600,
                    ),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Название",
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
                    controller: locationController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Локация",
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
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom /
                          kBottomKeyboardPaddingCoef,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                              Size(
                                MediaQuery.of(context).size.width * 0.425,
                                50.0,
                              ),
                            ),
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
                            "Отмена",
                            style: TextStyle(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                              Size(
                                MediaQuery.of(context).size.width * 0.425,
                                50.0,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              primaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
