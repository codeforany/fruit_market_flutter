import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AppContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  Future push(Widget widget) async {
    return Navigator.push(
        this, MaterialPageRoute(builder: (context) => widget));
  }

  Future pop() async {
    return Navigator.pop(this);
  }
}

extension MDExtensionState on State {
  void mdShowAlert(String title, String message, VoidCallback onPressed,
      {String buttonTitle = "Ok",
      TextAlign mainAxisAlignment = TextAlign.center,
      isForce = false}) {
    showDialog(
        context: context,
        barrierDismissible: !isForce,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  child: Text(buttonTitle),
                  isDefaultAction: true,
                  onPressed: () {
                    context.pop();
                    onPressed();
                  },
                )
              ],
            ));
  }

  void mdShowAlertTowButton(String title, String message,
      VoidCallback onOkPressed, VoidCallback onCancelPressed,
      {String buttonOkTitle = "Ok",
      String buttonCancelTitle = "Cancel",
      TextAlign mainAxisAlignment = TextAlign.center,
      isForce = false}) {
    showDialog(
        context: context,
        barrierDismissible: !isForce,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    context.pop();
                    onOkPressed();
                  },
                  child: Text(buttonOkTitle),
                ),
                CupertinoDialogAction(
                  isDefaultAction: false,
                  onPressed: () {
                    context.pop();
                    onCancelPressed();
                  },
                  child: Text(buttonCancelTitle),
                )
              ],
            ));
  }

  void endEditing() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

extension DateTimeExtension on DateTime {
  String stringFormat({String format = "yyyy-MM-dd HH:mm:ss"}) {
    return DateFormat(format).format(this);
  }
}

extension StringExtension on String {
  String displayDate(
      {String displayFormat = "dd MMM, yyyy",
      String inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
      int addMin = 0}) {
    var date = (DateFormat(inputFormat).parseUTC(this));
    return  DateFormat(displayFormat).format(date.add(Duration(minutes: 1)));
  }

  DateTime date(
      {
      String inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
      int addMin = 0}) {
    return (DateFormat(inputFormat).parseUTC(this));
  }
}
