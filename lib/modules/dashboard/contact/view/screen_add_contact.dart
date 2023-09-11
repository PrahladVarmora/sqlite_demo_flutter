import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silver_touch_task/modules/dashboard/category/bloc/category_bloc.dart';
import 'package:silver_touch_task/modules/dashboard/contact/bloc/add_contact_bloc.dart';
import 'package:silver_touch_task/modules/dashboard/contact/model/model_contact.dart';

import '../../../core/utils/common_import.dart';
import '../../category/model/model_category.dart';

///[ScreenAddContact] This class is use to Screen Add Contact
class ScreenAddContact extends StatefulWidget {
  final Function addedNewContact;
  final ModelContact mContact;

  const ScreenAddContact(
      {Key? key, required this.addedNewContact, required this.mContact})
      : super(key: key);

  @override
  State<ScreenAddContact> createState() => _ScreenAddContactState();
}

class _ScreenAddContactState extends State<ScreenAddContact> {
  /// * [firstNameController] is use for get category from user
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ValueNotifier<String> mImages = ValueNotifier<String>('');
  ValueNotifier<ModelCategory> selectedCategory =
      ValueNotifier(ModelCategory());

  ValueNotifier<List<ModelCategory>> mCategory = ValueNotifier([]);

  @override
  void initState() {
    initData();
    super.initState();
  }

  ///[initData] This function is use to init data of screen
  void initData() {
    if (widget.mContact.contactId != null) {
      mImages.value = widget.mContact.contactImage!;
      firstNameController.text = widget.mContact.contactFirstName!;
      lastNameController.text = widget.mContact.contactLastName!;
      mobileController.text = widget.mContact.contactMobile!;
      emailController.text = widget.mContact.contactEmail!;
    }

    BlocProvider.of<CategoryBloc>(context).add(CategoryList());
  }

  OutlineInputBorder mOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).cardColor, width: Dimens.margin1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiValueListenableBuilder(
        valueListenables: [selectedCategory, mImages, mCategory],
        builder: (context, values, Widget? child) {
          return BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryResponse) {
                mCategory.value = state.mModelCategory;

                if (widget.mContact.contactId != null) {
                  for (int i = 0; i < state.mModelCategory.length; i++) {
                    if (state.mModelCategory[i].categoryId ==
                        widget.mContact.contactCategory) {
                      selectedCategory.value = state.mModelCategory[i];
                      break;
                    }
                  }
                }

                if (selectedCategory.value.categoryId == null) {
                  selectedCategory.value = state.mModelCategory[0];
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimens.margin20),
              child: selectedCategory.value.categoryId != null
                  ? SingleChildScrollView(
                      child: BlocListener<AddContactBloc, AddContactState>(
                        listener: (context, state) {
                          if (state is AddContactFailure) {
                            ToastController.showToast(state.mError, false);
                          } else if (state is AddContactResponse) {
                            if (widget.mContact.contactId != null) {
                              ToastController.showToast(
                                  AppStrings.textContactUpdate, true);
                            } else {
                              ToastController.showToast(
                                  AppStrings.textContactAdded, true);
                            }
                            widget.addedNewContact();
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: Dimens.margin30),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.camera)
                                      .then((pickedFile) {
                                    if (pickedFile != null) {
                                      ImageCropper().cropImage(
                                        sourcePath: pickedFile.path,
                                        cropStyle: CropStyle.circle,
                                        aspectRatioPresets: [
                                          CropAspectRatioPreset.square
                                        ],
                                      ).then((croppedImage) {
                                        if (croppedImage != null) {
                                          mImages.value = croppedImage.path;
                                        }
                                      });
                                    }
                                  });
                                },
                                child: mImages.value.isEmpty
                                    ? const Icon(
                                        Icons.camera,
                                        size: 100,
                                      )
                                    : Image.file(
                                        File(
                                          mImages.value,
                                        ),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                              ),
                            ),
                            const SizedBox(height: Dimens.margin30),
                            TextFormField(
                              style: getTextStyle(
                                  Theme.of(context).textTheme.titleSmall!,
                                  Dimens.margin15,
                                  FontWeight.w600),
                              controller: firstNameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: AppStrings.textFirstName,
                                hintStyle: getTextStyle(
                                    Theme.of(context).textTheme.titleSmall!,
                                    Dimens.margin15,
                                    FontWeight.normal),
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: mOutlineInputBorder(),
                                focusedBorder: mOutlineInputBorder(),
                                disabledBorder: mOutlineInputBorder(),
                                border: mOutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: Dimens.margin30),
                            TextFormField(
                              style: getTextStyle(
                                  Theme.of(context).textTheme.titleSmall!,
                                  Dimens.margin15,
                                  FontWeight.w600),
                              textInputAction: TextInputAction.next,
                              controller: lastNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: AppStrings.textLastName,
                                hintStyle: getTextStyle(
                                    Theme.of(context).textTheme.titleSmall!,
                                    Dimens.margin15,
                                    FontWeight.normal),
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: mOutlineInputBorder(),
                                focusedBorder: mOutlineInputBorder(),
                                disabledBorder: mOutlineInputBorder(),
                                border: mOutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: Dimens.margin30),
                            TextFormField(
                              style: getTextStyle(
                                  Theme.of(context).textTheme.titleSmall!,
                                  Dimens.margin15,
                                  FontWeight.w600),
                              textInputAction: TextInputAction.next,
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: AppStrings.textMobile,
                                hintStyle: getTextStyle(
                                    Theme.of(context).textTheme.titleSmall!,
                                    Dimens.margin15,
                                    FontWeight.normal),
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: mOutlineInputBorder(),
                                focusedBorder: mOutlineInputBorder(),
                                disabledBorder: mOutlineInputBorder(),
                                border: mOutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: Dimens.margin30),
                            TextFormField(
                              style: getTextStyle(
                                  Theme.of(context).textTheme.titleSmall!,
                                  Dimens.margin15,
                                  FontWeight.w600),
                              textInputAction: TextInputAction.done,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: AppStrings.textEmail,
                                hintStyle: getTextStyle(
                                    Theme.of(context).textTheme.titleSmall!,
                                    Dimens.margin15,
                                    FontWeight.normal),
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: mOutlineInputBorder(),
                                focusedBorder: mOutlineInputBorder(),
                                disabledBorder: mOutlineInputBorder(),
                                border: mOutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: Dimens.margin30),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).cardColor,
                                        width: Dimens.margin1)),
                                child: DropdownButton<ModelCategory>(
                                  isExpanded: true,
                                  value: selectedCategory.value,
                                  underline: const SizedBox(),
                                  hint: Text(
                                    AppStrings.textSelectCategory,
                                    style: getTextStyle(
                                        Theme.of(context).textTheme.titleSmall!,
                                        Dimens.margin15,
                                        FontWeight.normal),
                                  ),
                                  style: getTextStyle(
                                      Theme.of(context).textTheme.titleSmall!,
                                      Dimens.margin15,
                                      FontWeight.normal),
                                  items: mCategory.value
                                      .map((ModelCategory value) {
                                    return DropdownMenuItem<ModelCategory>(
                                      value: value,
                                      child: Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        width: double.infinity,
                                        child: Text(
                                          value.categoryName!,
                                          style: getTextStyle(
                                              Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!,
                                              Dimens.margin15,
                                              FontWeight.normal),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (mCat) {
                                    selectedCategory.value = mCat!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimens.margin30),
                            CustomButton(
                              height: Dimens.margin50,
                              width: Dimens.margin150,
                              backgroundColor: Theme.of(context).cardColor,
                              borderColor: Theme.of(context).cardColor,
                              borderRadius: Dimens.margin0,
                              onPress: () {
                                if (widget.mContact.contactId != null) {
                                  BlocProvider.of<AddContactBloc>(context).add(
                                      EditContact(
                                          image: mImages.value,
                                          contactId: widget.mContact.contactId!,
                                          firstName:
                                              firstNameController.text.trim(),
                                          lastName:
                                              lastNameController.text.trim(),
                                          mobile: mobileController.text.trim(),
                                          email: emailController.text.trim(),
                                          catId: selectedCategory
                                              .value.categoryId!));
                                } else {
                                  BlocProvider.of<AddContactBloc>(context).add(
                                      AddContact(
                                          image: mImages.value,
                                          firstName:
                                              firstNameController.text.trim(),
                                          lastName:
                                              lastNameController.text.trim(),
                                          mobile: mobileController.text.trim(),
                                          email: emailController.text.trim(),
                                          catId: selectedCategory
                                              .value.categoryId!));
                                }
                              },
                              buttonText: widget.mContact.contactId != null
                                  ? AppStrings.textUpdate
                                  : AppStrings.textSave,
                              style: getTextStyle(
                                  Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall!,
                                  Dimens.textSize15,
                                  FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(AppStrings.textPleaseAddCategory),
                    ),
            ),
          );
        },
      ),
    );
  }
}
