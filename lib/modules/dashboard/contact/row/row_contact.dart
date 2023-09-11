import 'dart:io';

import 'package:silver_touch_task/modules/dashboard/contact/model/model_contact.dart';

import '../../../core/utils/common_import.dart';

///[RowContact] This class is use to Row Contact
class RowContact extends StatelessWidget {
  final ModelContact mModelContact;
  final Function onEdit;
  final Function onDelete;

  const RowContact(
      {Key? key,
      required this.mModelContact,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(Dimens.margin16),
        // color: Theme.of(context).primaryColorDark,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).cardColor, width: 2)),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).cardColor,
                    maxRadius: Dimens.margin25,
                    minRadius: Dimens.margin25,
                    foregroundImage: FileImage(
                      File(
                        mModelContact.contactImage!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: Dimens.margin50,
                    padding: const EdgeInsets.only(
                        left: Dimens.margin10,
                        top: Dimens.margin10,
                        bottom: Dimens.margin10),
                    child: Text(
                      mModelContact.contactFirstName!,
                      style: getTextStyle(
                          Theme.of(context).textTheme.titleSmall!,
                          Dimens.margin15,
                          FontWeight.normal),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => onEdit(),
                    icon: Image.asset(
                      APPImages.icEdit,
                      height: Dimens.margin20,
                      width: Dimens.margin20,
                    )),
                IconButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    icon: Image.asset(
                      APPImages.icDelete,
                      height: Dimens.margin20,
                      width: Dimens.margin20,
                    )),
              ],
            ),
            const SizedBox(height: Dimens.margin10),
            Container(color: Theme.of(context).cardColor, height: 1)
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(AppStrings.textDelete),
      onPressed: () {
        onDelete();
      },
    );

// set up the button
    Widget cancelButton = TextButton(
      child: const Text(AppStrings.textCancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppStrings.textAlert,
          style: getTextStyle(Theme.of(context).textTheme.titleSmall!,
              Dimens.margin18, FontWeight.bold)),
      content: Text(AppStrings.textDeleteContactConfirm,
          style: getTextStyle(Theme.of(context).textTheme.titleSmall!,
              Dimens.margin15, FontWeight.normal)),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
