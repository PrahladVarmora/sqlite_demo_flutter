import 'package:silver_touch_task/modules/core/utils/common_import.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../category/view/screen_category.dart';
import '../contact/model/model_contact.dart';
import '../contact/view/screen_add_contact.dart';
import '../contact/view/screen_contact.dart';

///[ScreenDashboard] This is class is use to Screen Dashboard
class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  GlobalKey drawerKey = GlobalKey();
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<ModelContact> mModelContact = ValueNotifier(ModelContact());

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: [selectedIndex, mModelContact],
      builder: (context, values, Widget? child) {
        return Material(
          child: SlideDrawer(
            backgroundColor: Theme.of(context).canvasColor,
            items: [
              MenuItem(AppStrings.textAddCategory, onTap: () {
                selectedIndex.value = 0;
              }),
              MenuItem(AppStrings.textAddContact, onTap: () {
                selectedIndex.value = 1;
                mModelContact.value = ModelContact();
              }),
              MenuItem(AppStrings.textContactList, onTap: () {
                selectedIndex.value = 2;
              }),
            ],
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  getTitle(),
                  style: getTextStyle(Theme.of(context).textTheme.titleMedium!,
                      Dimens.margin18, FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).cardColor,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    SlideDrawer.of(context)?.activate();
                    SlideDrawer.of(context)?.toggle();
                  },
                ),
              ),
              body: selectedIndex.value == 0
                  ? const ScreenCategory()
                  : selectedIndex.value == 1
                      ? ScreenAddContact(
                          addedNewContact: () {
                            selectedIndex.value = 2;
                          },
                          mContact: mModelContact.value,
                        )
                      : ScreenContact(editContact: (ModelContact mContact) {
                          mModelContact.value = mContact;
                          selectedIndex.value = 1;
                        }),
            ),
          ),
        );
      },
    );
  }

  ///[getTitle] this is app title
  String getTitle() {
    if (selectedIndex.value == 0) {
      return AppStrings.textCreateAndStoreCategory;
    } else if (selectedIndex.value == 1) {
      return AppStrings.textAddContact;
    } else {
      return AppStrings.textContactList;
    }
  }
}
