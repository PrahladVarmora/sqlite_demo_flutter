import 'package:silver_touch_task/modules/dashboard/contact/bloc/add_contact_bloc.dart';
import 'package:silver_touch_task/modules/dashboard/contact/model/model_contact.dart';

import '../../../core/utils/common_import.dart';
import '../bloc/contact_bloc.dart';
import '../row/row_contact.dart';

///[ScreenContact] This class is use to Screen Contact List
class ScreenContact extends StatefulWidget {
  final Function(ModelContact) editContact;

  const ScreenContact({Key? key, required this.editContact}) : super(key: key);

  @override
  State<ScreenContact> createState() => _ScreenContactState();
}

class _ScreenContactState extends State<ScreenContact> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  ///[initData] This function is use to init data of screen
  void initData() {
    BlocProvider.of<ContactBloc>(context).add(Contact());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddContactBloc, AddContactState>(
        listener: (context, state) {
          if (state is AddContactResponse) {
            initData();
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return state is ContactResponse
                ? state.mContact.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return RowContact(
                            mModelContact: state.mContact[index],
                            onEdit: () {
                              widget.editContact(state.mContact[index]);
                            },
                            onDelete: () {
                              Navigator.pop(context);
                              BlocProvider.of<AddContactBloc>(context).add(
                                  DeleteContact(
                                      contactId:
                                          state.mContact[index].contactId!));
                            },
                          );
                        },
                        itemCount: state.mContact.length,
                      )
                    : Center(
                        child: Text(
                          AppStrings.textNoData,
                          style: getTextStyle(
                              Theme.of(context).textTheme.titleSmall!,
                              Dimens.margin15,
                              FontWeight.normal),
                        ),
                      )
                : Center(
                    child: state is ContactFailure
                        ? Text(
                            state.mError,
                            style: getTextStyle(
                                Theme.of(context).textTheme.titleSmall!,
                                Dimens.margin15,
                                FontWeight.normal),
                          )
                        : Text(
                            AppStrings.textLoading,
                            style: getTextStyle(
                                Theme.of(context).textTheme.titleSmall!,
                                Dimens.margin15,
                                FontWeight.normal),
                          ),
                  );
          },
        ),
      ),
    );
  }
}
