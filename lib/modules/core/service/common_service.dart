import '../utils/common_import.dart';

/// A [getTextStyle] This Method Use to getTextStyle
TextStyle getTextStyle(
    TextStyle mainTextStyle, double size, FontWeight fontWeight) {
  return mainTextStyle.copyWith(fontSize: size, fontWeight: fontWeight);
}

/// A [validateEmail] widget is a widget that describes part of validate Phone number
bool validateEmail(String data) =>
    RegExp(r'^[a-z0-9](\.?[a-z0-9_-])*@[a-z0-9-]+\.([a-z]{2,6}\.)?[a-z]{2,6}$')
        .hasMatch(data);
