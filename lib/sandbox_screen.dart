import 'package:flutter/material.dart';
import 'package:kupol_app/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SandboxScreen extends StatelessWidget {
  const SandboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "PIN",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              PinCodeTextField(
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
                  fieldOuterPadding: EdgeInsets.symmetric(horizontal: 8),
                  fieldWidth: 30,
                  fieldHeight: 40,
                  shape: PinCodeFieldShape.underline,
                  activeColor: secondaryGreyColor,
                  inactiveColor: darkTextSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
