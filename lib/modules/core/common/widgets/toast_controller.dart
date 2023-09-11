import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/common_import.dart';

/// A [ToastController] widget is a widget that describes part of the user interface by ToastController
/// * [mModelStaffMember] which contains the Toast Text
/// * [BuildContext] which contains the Toast context
/// * [bool] which contains the isSuccess or not
class ToastController {
  static showToast(String message, bool isSuccess, {int time = 2}) {
    if (kIsWeb) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          webShowClose: true,
          webPosition: 'center',
          webBgColor: isSuccess
              ? 'linear-gradient(to right, #2E7D32, #2E7D32)'
              : 'linear-gradient(to right, #fe4f4f, #fe4f4f)',
          fontSize: 16.0);
    } else {
      final snackBar = SnackBar(
        content: Text(
          message,
          style: getTextStyle(
              Theme.of(NavigatorKey.navigatorKey.currentContext!).textTheme.titleSmall!,
              Dimens.margin15,
              FontWeight.w500),
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: Duration(seconds: time),
      );
      ScaffoldMessenger.of(NavigatorKey.navigatorKey.currentContext!).showSnackBar(snackBar);
    }
  }

  static removeToast(BuildContext context) {
    if (kIsWeb) {
      Fluttertoast.cancel();
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }
}
