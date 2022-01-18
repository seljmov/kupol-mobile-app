import 'package:flutter/material.dart';
import 'package:kupol_app/components/role.dart';

/// value -> "error:"
final errorPattern = "error:";

final kEventNewStatusColor = Color(0xFF3CB047);
final kEventOnVerificationStatusColor = Color(0xFFE94235);
final kEventNewAtWorkColor = Color(0xFF0075B0);
final kEventCompletedStatusColor = Color(0xFF4F4E4E);

/// symmetric(vertical: 10, horizontal: 24)
const kDetailScreenPadding = const EdgeInsets.symmetric(
  vertical: 10,
  horizontal: 24,
);

final catchFocus =
    (context) => FocusScope.of(context).requestFocus(FocusNode());

String getRoleName(Role role) {
  if (role == Role.security) return "Сотрудник охраны";
  if (role == Role.gbr) return "Сотрудник ГБР";
  if (role == Role.technician) return "Техник";

  return "";
}
