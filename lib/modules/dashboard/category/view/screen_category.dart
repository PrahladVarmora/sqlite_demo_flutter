import 'package:silver_touch_task/modules/dashboard/category/model/model_category.dart';

import '../../../core/utils/common_import.dart';
import '../bloc/add_category_bloc.dart';
import '../bloc/category_bloc.dart';
import '../row/row_category.dart';

///[ScreenCategory] This class is use to Screen Category UI and Category List
class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  /// * [nameController] is use for get category from user
  TextEditingController nameController = TextEditingController();

  ValueNotifier<ModelCategory> editCategory = ValueNotifier(ModelCategory());

  @override
  void initState() {
    initData();
    super.initState();
  }

  ///[initData] This function is use to init data of screen
  void initData() {
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: MultiValueListenableBuilder(
        valueListenables: [editCategory],
        builder: (context, values, Widget? child) {
          return BlocListener<AddCategoryBloc, AddCategoryState>(
            listener: (context, state) {
              if (state is AddCategoryResponse) {
                nameController.text = '';
                editCategory.value = ModelCategory();
                initData();
              }
              if (state is AddCategoryFailure) {
                ToastController.showToast(state.mError, false);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimens.margin20),
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimens.margin100,
                  ),
                  TextFormField(
                    style: getTextStyle(Theme.of(context).textTheme.titleSmall!,
                        Dimens.margin15, FontWeight.w600),
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.textAddCategory,
                      hintStyle: getTextStyle(
                          Theme.of(context).textTheme.titleSmall!,
                          Dimens.margin15,
                          FontWeight.normal),
                      enabledBorder: mOutlineInputBorder(),
                      focusedBorder: mOutlineInputBorder(),
                      disabledBorder: mOutlineInputBorder(),
                      border: mOutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Dimens.margin50),
                  CustomButton(
                    height: Dimens.margin50,
                    width: Dimens.margin150,
                    backgroundColor: Theme.of(context).cardColor,
                    borderColor: Theme.of(context).cardColor,
                    borderRadius: Dimens.margin0,
                    onPress: () {
                      if (editCategory.value.categoryName != null) {
                        BlocProvider.of<AddCategoryBloc>(context).add(
                            EditCategory(
                                categoryName: nameController.text,
                                categoryId: editCategory.value.categoryId!));
                      } else {
                        BlocProvider.of<AddCategoryBloc>(context).add(
                            AddCategory(categoryName: nameController.text));
                      }
                    },
                    buttonText: editCategory.value.categoryName != null
                        ? AppStrings.textUpdate
                        : AppStrings.textSave,
                    style: getTextStyle(
                        Theme.of(context).primaryTextTheme.titleSmall!,
                        Dimens.textSize15,
                        FontWeight.w400),
                  ),
                  const SizedBox(height: Dimens.margin50),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      return state is CategoryResponse
                          ? Expanded(
                              child: ListView.builder(
                              itemBuilder: (context, index) {
                                return RowCategory(
                                  mModelCategory: state.mModelCategory[index],
                                  onEdit: () {
                                    editCategory.value =
                                        state.mModelCategory[index];
                                    nameController.text =
                                        editCategory.value.categoryName!;
                                  },
                                  onDelete: () {
                                    Navigator.pop(context);
                                    BlocProvider.of<AddCategoryBloc>(context)
                                        .add(DeleteCategory(
                                            categoryId: state
                                                .mModelCategory[index]
                                                .categoryId!));
                                  },
                                );
                              },
                              itemCount: state.mModelCategory.length,
                            ))
                          : Expanded(
                              child: Center(
                              child: state is CategoryFailure
                                  ? Text(
                                      state.mError,
                                      style: getTextStyle(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!,
                                          Dimens.margin15,
                                          FontWeight.normal),
                                    )
                                  : Text(
                                      AppStrings.textLoading,
                                      style: getTextStyle(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!,
                                          Dimens.margin15,
                                          FontWeight.normal),
                                    ),
                            ));
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
