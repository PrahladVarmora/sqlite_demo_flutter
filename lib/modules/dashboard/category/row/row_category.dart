import '../../../core/utils/common_import.dart';
import '../model/model_category.dart';

///[RowCategory] This class is use to Row Category
class RowCategory extends StatelessWidget {
  final ModelCategory mModelCategory;
  final Function onEdit;
  final Function onDelete;

  const RowCategory(
      {Key? key,
      required this.mModelCategory,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColorDark,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: Dimens.margin50,
                    padding: const EdgeInsets.only(
                        left: Dimens.margin20,
                        top: Dimens.margin10,
                        bottom: Dimens.margin10),
                    child: Text(
                      mModelCategory.categoryName!,
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
            Container(color: Theme.of(context).primaryColorLight, height: 1)
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
      content: Text(AppStrings.textDeleteCategoryConfirm,
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
