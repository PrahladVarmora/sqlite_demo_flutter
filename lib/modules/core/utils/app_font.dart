import 'package:silver_touch_task/modules/core/utils/common_import.dart';

/// > AppFont is a class that contains a static method that returns a font family name
class AppFont {
  static final regular =
      GoogleFonts.roboto(fontWeight: FontWeight.w400, color: AppColors.colorBlack);
  static final bold = GoogleFonts.roboto(fontWeight: FontWeight.w700, color: AppColors.colorBlack);
  static final semiBold =
      GoogleFonts.roboto(fontWeight: FontWeight.w600, color: AppColors.colorBlack);
  static final mediumBold =
      GoogleFonts.roboto(fontWeight: FontWeight.w500, color: AppColors.colorBlack);

  ///-------REGULAR-------------
  static final semiBoldBlack = regular.copyWith(color: AppColors.colorBlack);
  static final white = regular.copyWith(color: AppColors.colorWhite);
}
