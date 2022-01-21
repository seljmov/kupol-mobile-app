import 'package:flutter/material.dart';
import 'package:kupol_app/shared/models/event_status.dart';

/// value -> "error:"
final errorPattern = "error:";

final kEventNewStatusColor = Color(0xFF3CB047);
final kEventOnVerificationStatusColor = Color(0xFFE94235);
final kEventNewAtWorkColor = Color(0xFF0075B0);
final kEventCompletedStatusColor = Color(0xFF4F4E4E);

/// symmetric(vertical: 16, horizontal: 20)
const kEventsScreenPadding = const EdgeInsets.symmetric(
  vertical: 16,
  horizontal: 20,
);

/// symmetric(vertical: 10, horizontal: 24)
const kDetailScreenPadding = const EdgeInsets.symmetric(
  vertical: 10,
  horizontal: 24,
);

/// symmetric(vertical: 16, horizontal: 20)
const kCardPadding = const EdgeInsets.symmetric(
  vertical: 16,
  horizontal: 20,
);

/// SizedBox(height: 48)
const kBottomSizedBox = SizedBox(height: 48);

/// (context) => FocusScope.of(context).requestFocus(FocusNode());
final catchFocus =
    (context) => FocusScope.of(context).requestFocus(FocusNode());

/// Возвращает цвет по статусу события
Color getEventStatusColor(String status) {
  if (status == EventStatus.New) return kEventNewStatusColor;
  if (status == EventStatus.InWork) return kEventNewAtWorkColor;
  if (status == EventStatus.OnVerification)
    return kEventOnVerificationStatusColor;
  if (status == EventStatus.Completed) return kEventCompletedStatusColor;
  return kEventNewAtWorkColor;
}
